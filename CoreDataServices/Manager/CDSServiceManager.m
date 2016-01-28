//
//  CoreDataServices.m
//  CoreDataServices
//
//  Created by William Boles on 15/04/2014.
//  Copyright (c) 2014 Boles. All rights reserved.
//

#import "CDSServiceManager.h"

static NSString * const CDSPersistentStoreDirectoryName = @"persistent-store";
static NSString * const CDSPersistentStoreFileExtension = @"sqlite";

static CDSServiceManager *sharedInstance = nil;

@interface CDSServiceManager ()

@property (nonatomic, strong) NSURL *modelURL;
@property (nonatomic, strong, readonly) NSURL *storeDirectoryURL;
@property (nonatomic, strong, readonly) NSURL *storeURL;
@property (nonatomic, strong, readwrite) NSManagedObjectContext *mainManagedObjectContext;
@property (nonatomic, strong, readwrite) NSManagedObjectContext *backgroundManagedObjectContext;
@property (nonatomic, strong, readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong, readwrite) NSManagedObjectModel *managedObjectModel;

/**
 Will attempt to create the persistent store and assign that persistent store to the coordinator.
 
 @param deleteAndRetry - will delete the current persistent store and try creating it fresh. This can happen where lightweight migration has failed.
 */
- (void)createPersistentStoreAndAssignToCoordinatorWithDeleteAndRetryOnError:(BOOL)deleteAndRetry;

/**
 Deletes the persistent store from the file system.
 */
- (void)deletePersistentStore;

@end

@implementation CDSServiceManager

#pragma mark - SharedInstance

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      sharedInstance = [[CDSServiceManager alloc] init];
                  });
    
    return sharedInstance;
}

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        //Make sure that we don't lose anything when the app is terminating
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(saveMainManagedObjectContext)
                                                     name:UIApplicationWillTerminateNotification
                                                   object:nil];
    }
    
    return self;
}

#pragma mark - Stack

- (NSManagedObjectModel *)managedObjectModel
{
    if (!_managedObjectModel)
    {
        _managedObjectModel = [[NSManfagedObjectModel alloc] initWithContentsOfURL:self.modelURL];
    }
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (!_persistentStoreCoordinator)
    {
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        
        [self createPersistentStoreAndAssignToCoordinatorWithDeleteAndRetryOnError:YES];
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)mainManagedObjectContext
{
    @synchronized(self)
    {
        if (!_mainManagedObjectContext)
        {
            _mainManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
            [_mainManagedObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
        }
        
        return _mainManagedObjectContext;
    }
}

- (NSManagedObjectContext *)backgroundManagedObjectContext
{
    @synchronized(self)
    {
        if (!_backgroundManagedObjectContext)
        {
            _backgroundManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
            [_backgroundManagedObjectContext setParentContext:self.mainManagedObjectContext];
            
            [_backgroundManagedObjectContext setUndoManager:nil];
        }
        
        return _backgroundManagedObjectContext;
    }
}

#pragma mark - Setup

- (void)setupModelURLWithModelName:(NSString *)name
{
    self.modelURL = [[NSBundle mainBundle] URLForResource:name
                                            withExtension:@"momd"];
}

#pragma mark - Clear

- (void)clear
{
    self.mainManagedObjectContext = nil;
    self.backgroundManagedObjectContext = nil;
    
    self.persistentStoreCoordinator = nil;
    self.managedObjectModel = nil;
    
    [self deletePersistentStore];
}

- (void)deletePersistentStore
{
    [[NSFileManager defaultManager] removeItemAtURL:self.storeDirectoryURL
                                              error:nil];
}

#pragma mark - CreatePersistentStore

- (void)createPersistentStoreAndAssignToCoordinatorWithDeleteAndRetryOnError:(BOOL)deleteAndRetry
{
    NSError *fileManagerError = nil;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:self.storeDirectoryURL.path
                           isDirectory:NULL])
    {
        [fileManager createDirectoryAtURL:self.storeDirectoryURL
              withIntermediateDirectories:NO
                               attributes:nil
                                    error:&fileManagerError];
    }
    
    if (!fileManagerError)
    {
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        
        NSError *persistentStoreError = nil;
        
        [self.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                      configuration:nil
                                                                URL:self.storeURL
                                                            options:options
                                                              error:&persistentStoreError];
        
        if (persistentStoreError)
        {
            if (deleteAndRetry)
            {
                NSLog(@"Unresolved persistent store error %@, %@", persistentStoreError, [persistentStoreError userInfo]);
                NSLog(@"Deleting and retrying");
                
                [self deletePersistentStore];
                
                [self createPersistentStoreAndAssignToCoordinatorWithDeleteAndRetryOnError:NO];
            }
            else
            {
                NSLog(@"Serious error with persistent store %@, %@", persistentStoreError, [persistentStoreError userInfo]);
            }
        }
    }
    else
    {
        NSLog(@"Unable to create persistent store on file system due to error %@, %@", fileManagerError, [fileManagerError userInfo]);
    }
}

#pragma mark - URLs

- (NSURL *)storeDirectoryURL
{
    NSURL *applicationDocumentURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                                            inDomains:NSUserDomainMask] lastObject];
    
    NSURL *storeDirectoryURL = [applicationDocumentURL URLByAppendingPathComponent:CDSPersistentStoreDirectoryName];
    
    return storeDirectoryURL;
}

- (NSURL *)storeURL
{
    NSString *modelFileName = [[self.modelURL lastPathComponent] stringByDeletingPathExtension];
    NSString *storeFilePath = [NSString stringWithFormat:@"%@.%@", modelFileName, CDSPersistentStoreFileExtension];
    NSURL *storeURL = [self.storeDirectoryURL URLByAppendingPathComponent:storeFilePath];
    
    return storeURL;
}

#pragma mark - Save

- (void)saveMainManagedObjectContext
{
    [self.mainManagedObjectContext performBlockAndWait:^
     {
         if (self.mainManagedObjectContext.hasChanges)
         {
             NSError *error = nil;
             
             if (![self.mainManagedObjectContext save:&error])
             {
                 NSLog(@"Couldn't save the main context: %@", [error userInfo]);
             }
             else
             {
                 //Force context to process pending changes as cascading deletes may not be immediately applied by coredata.
                 [self.mainManagedObjectContext processPendingChanges];
             }
         }
     }];
}

- (void)saveBackgroundManagedObjectContext
{
    [self.backgroundManagedObjectContext performBlockAndWait:^
     {
         if (self.backgroundManagedObjectContext.hasChanges)
         {
             NSError *error = nil;
             
             if (![self.backgroundManagedObjectContext save:&error])
             {
                 NSLog(@"Couldn't save the background context: %@", [error userInfo]);
             }
             else
             {
                 //Force context to process pending changes as cascading deletes may not be immediately applied by coredata.
                 [self.backgroundManagedObjectContext processPendingChanges];
                 
                 //Don't want to changes to be lost if the app crashes so let's save these changes to the persistent store
                 [self saveMainManagedObjectContext];
             }
         }
     }];
}

@end

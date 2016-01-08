//
//  CDSDeletionService.m
//  CoreDataServices
//
//  Created by William Boles on 11/03/2013.
//  Copyright (c) 2013 Boles. All rights reserved.
//

#import "CDSDeletionService.h"

#import "NSManagedObjectContext+CDSRetrieval.h"
#import "CDSServiceManager.h"

@implementation CDSDeletionService

#pragma mark - Single

+ (void)deleteManagedObject:(NSManagedObject *)managedObject
{
    [CDSDeletionService deleteManagedObject:managedObject
                          saveAfterDeletion:YES
                       managedObjectContext:[CDSServiceManager sharedInstance].managedObjectContext];
}

+ (void)deleteManagedObject:(NSManagedObject *)managedObject saveAfterDeletion:(BOOL)saveAfterDeletion
{
    [CDSDeletionService deleteManagedObject:managedObject
                          saveAfterDeletion:saveAfterDeletion
                       managedObjectContext:[CDSServiceManager sharedInstance].managedObjectContext];
}

+ (void)deleteManagedObject:(NSManagedObject *)managedObject managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    [CDSDeletionService deleteManagedObject:managedObject
                          saveAfterDeletion:YES
                       managedObjectContext:managedObjectContext];
}

+ (void)deleteManagedObject:(NSManagedObject *)managedObject
          saveAfterDeletion:(BOOL)saveAfterDeletion
       managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    if (managedObject &&
        managedObjectContext)
    {
        [managedObjectContext deleteObject:managedObject];
        
        if (saveAfterDeletion)
        {
            if ([managedObjectContext save:nil])
            {
                //Force context to process pending changes as
                //cascading deletes may not be immediatly applied by coredata.
                [managedObjectContext processPendingChanges];
            }
        }
    }
}

#pragma mark - Multiple

+ (void)deleteEntriesForEntityClass:(Class)entityClass
                          predicate:(NSPredicate *)predicate
                  saveAfterDeletion:(BOOL)saveAfterDeletion
               managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSArray *entities = [managedObjectContext retrieveEntriesForEntityClass:entityClass
                                                                 predicate:predicate];
    
    for (NSManagedObject *entity in entities)
    {
        [CDSDeletionService deleteManagedObject:entity
                              saveAfterDeletion:NO
                           managedObjectContext:managedObjectContext];
    }
    
    if (saveAfterDeletion)
    {
        if ([managedObjectContext save:nil])
        {
            //Force context to process pending changes as
            //cascading deletes may not be immediatly applied by coredata.
            [managedObjectContext processPendingChanges];
        }
    }
}

+ (void)deleteEntriesForEntityClass:(Class)entityClass
                          predicate:(NSPredicate *)predicate
               managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    [CDSDeletionService deleteEntriesForEntityClass:entityClass
                                          predicate:predicate
                                  saveAfterDeletion:YES
                               managedObjectContext:managedObjectContext];
}

+ (void)deleteEntriesForEntityClass:(Class)entityClass
                          predicate:(NSPredicate *)predicate
{
    [CDSDeletionService deleteEntriesForEntityClass:entityClass
                                          predicate:predicate
                                  saveAfterDeletion:YES
                               managedObjectContext:[CDSServiceManager sharedInstance].managedObjectContext];
}

+ (void)deleteEntriesForEntityClass:(Class)entityClass
                          predicate:(NSPredicate *)predicate
                  saveAfterDeletion:(BOOL)saveAfterDeletion
{
    [CDSDeletionService deleteEntriesForEntityClass:entityClass
                                          predicate:predicate
                                  saveAfterDeletion:saveAfterDeletion
                               managedObjectContext:[CDSServiceManager sharedInstance].managedObjectContext];
}

+ (void)deleteEntriesForEntityClass:(Class)entityClass
{
    [CDSDeletionService deleteEntriesForEntityClass:entityClass
                                          predicate:nil
                                  saveAfterDeletion:YES
                               managedObjectContext:[CDSServiceManager sharedInstance].managedObjectContext];
}

+ (void)deleteEntriesForEntityClass:(Class)entityClass
                  saveAfterDeletion:(BOOL)saveAfterDeletion
{
    [CDSDeletionService deleteEntriesForEntityClass:entityClass
                                          predicate:nil
                                  saveAfterDeletion:saveAfterDeletion
                               managedObjectContext:[CDSServiceManager sharedInstance].managedObjectContext];
}

+ (void)deleteEntriesForEntityClass:(Class)entityClass
               managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    [CDSDeletionService deleteEntriesForEntityClass:entityClass
                                          predicate:nil
                                  saveAfterDeletion:YES
                               managedObjectContext:managedObjectContext];
}

+ (void)deleteEntriesForEntityClass:(Class)entityClass
                  saveAfterDeletion:(BOOL)saveAfterDeletion
               managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    [CDSDeletionService deleteEntriesForEntityClass:entityClass
                                          predicate:nil
                                  saveAfterDeletion:saveAfterDeletion
                               managedObjectContext:managedObjectContext];
}

@end

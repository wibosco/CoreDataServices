//
//  NSManagedObjectContext+CDSDelete.m
//  CoreDataServices
//
//  Created by William Boles on 08/01/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import "NSManagedObjectContext+CDSDelete.h"

#import "NSManagedObjectContext+CDSRetrieval.h"
#import "CDSServiceManager.h"

@implementation NSManagedObjectContext (CDSDelete)

#pragma mark - Single

- (void)deleteManagedObject:(NSManagedObject *)managedObject
{
    [self deleteManagedObject:managedObject
            saveAfterDeletion:YES];
}

- (void)deleteManagedObject:(NSManagedObject *)managedObject
          saveAfterDeletion:(BOOL)saveAfterDeletion
{
    if (managedObject)
    {
        [self deleteObject:managedObject];
        
        if (saveAfterDeletion)
        {
            if ([self save:nil])
            {
                //Force context to process pending changes as
                //cascading deletes may not be immediatly applied by coredata.
                [self processPendingChanges];
            }
        }
    }
}

#pragma mark - Multiple

- (void)deleteEntriesForEntityClass:(Class)entityClass
                          predicate:(NSPredicate *)predicate
                  saveAfterDeletion:(BOOL)saveAfterDeletion
{
    NSArray *entities = [self retrieveEntriesForEntityClass:entityClass
                                                  predicate:predicate];
    
    for (NSManagedObject *entity in entities)
    {
        [self deleteManagedObject:entity
                saveAfterDeletion:NO];
    }
    
    if (saveAfterDeletion)
    {
        if ([self save:nil])
        {
            //Force context to process pending changes as
            //cascading deletes may not be immediatly applied by coredata.
            [self processPendingChanges];
        }
    }
}

- (void)deleteEntriesForEntityClass:(Class)entityClass
                          predicate:(NSPredicate *)predicate
{
    [self deleteEntriesForEntityClass:entityClass
                            predicate:predicate
                    saveAfterDeletion:YES];
}

- (void)deleteEntriesForEntityClass:(Class)entityClass
{
    [self deleteEntriesForEntityClass:entityClass
                            predicate:nil
                    saveAfterDeletion:YES];
}

- (void)deleteEntriesForEntityClass:(Class)entityClass
                  saveAfterDeletion:(BOOL)saveAfterDeletion
{
    [self deleteEntriesForEntityClass:entityClass
                            predicate:nil
                    saveAfterDeletion:saveAfterDeletion];
}

@end

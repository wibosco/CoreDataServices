//
//  CDSDeletionService.m
//  CoreDataServices
//
//  Created by William Boles on 11/03/2013.
//  Copyright (c) 2013 Boles. All rights reserved.
//

#import "CDSDeletionService.h"
#import "CDSRetrievalService.h"

@implementation CDSDeletionService

#pragma mark - Single

+ (void) deleteManagedObject:(NSManagedObject *)managedObject
{
    [CDSDeletionService deleteManagedObject:managedObject
                          saveAfterDeletion:YES
                       managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (void) deleteManagedObject:(NSManagedObject *)managedObject saveAfterDeletion:(BOOL)saveAfterDeletion
{
    [CDSDeletionService deleteManagedObject:managedObject
                          saveAfterDeletion:saveAfterDeletion
                       managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (void) deleteManagedObject:(NSManagedObject *)managedObject managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    [CDSDeletionService deleteManagedObject:managedObject
                          saveAfterDeletion:YES
                       managedObjectContext:managedObjectContext];
}

+ (void) deleteManagedObject:(NSManagedObject *)managedObject
           saveAfterDeletion:(BOOL)saveAfterDeletion
        managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    if (managedObject &&
        managedObjectContext)
    {
        [managedObjectContext deleteObject:managedObject];
        
        if (saveAfterDeletion)
        {
           [CDSServiceManager saveManagedObjectContext:managedObjectContext]; 
        }
    }
}

#pragma mark - Multiple

+ (void) deleteEntriesForEntityName:(NSString *)entityName
                          predicate:(NSPredicate *)predicate
               managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    [CDSDeletionService deleteEntriesForEntityName:entityName
                                         predicate:predicate
                                 saveAfterDeletion:YES
                                managedObjectContext:managedObjectContext];
}

+ (void) deleteEntriesForEntityName:(NSString *)entityName
                          predicate:(NSPredicate *)predicate
                  saveAfterDeletion:(BOOL)saveAfterDeletion
               managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSArray *entities = [CDSRetrievalService retrieveEntriesForEntityName:entityName
                                                                predicate:predicate
                                                     managedObjectContext:managedObjectContext];
    
    for (NSManagedObject *entity in entities)
    {
        [CDSDeletionService deleteManagedObject:entity
                              saveAfterDeletion:saveAfterDeletion
                           managedObjectContext:managedObjectContext];
    }
}

+ (void) deleteEntriesForEntityClass:(Class)entityClass
                     predicate:(NSPredicate *)predicate
                managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    [CDSDeletionService deleteEntriesForEntityName:NSStringFromClass(entityClass)
                                         predicate:predicate
                                 saveAfterDeletion:YES
                              managedObjectContext:managedObjectContext];
}

+ (void) deleteEntriesForEntityClass:(Class)entityClass
                     predicate:(NSPredicate *)predicate
                   saveAfterDeletion:(BOOL)saveAfterDeletion
                managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    [CDSDeletionService deleteEntriesForEntityName:NSStringFromClass(entityClass)
                                         predicate:predicate
                                 saveAfterDeletion:saveAfterDeletion
                              managedObjectContext:managedObjectContext];
}

+ (void) deleteEntriesForEntityName:(NSString *)entityName
                    predicate:(NSPredicate *)predicate
{
    [CDSDeletionService deleteEntriesForEntityName:entityName
                                         predicate:predicate
                                 saveAfterDeletion:YES
                              managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (void) deleteEntriesForEntityName:(NSString *)entityName
                    predicate:(NSPredicate *)predicate
                  saveAfterDeletion:(BOOL)saveAfterDeletion
{
    [CDSDeletionService deleteEntriesForEntityName:entityName
                                         predicate:predicate
                                 saveAfterDeletion:saveAfterDeletion
                              managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (void) deleteEntriesForEntityClass:(Class)entityClass
                     predicate:(NSPredicate *)predicate
{
    [CDSDeletionService deleteEntriesForEntityName:NSStringFromClass(entityClass)
                                         predicate:predicate
                                 saveAfterDeletion:YES
                              managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (void) deleteEntriesForEntityClass:(Class)entityClass
                     predicate:(NSPredicate *)predicate
                   saveAfterDeletion:(BOOL)saveAfterDeletion
{
    [CDSDeletionService deleteEntriesForEntityName:NSStringFromClass(entityClass)
                                         predicate:predicate
                                 saveAfterDeletion:saveAfterDeletion
                              managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (void) deleteEntriesForEntityName:(NSString *)entityName
{
    [CDSDeletionService deleteEntriesForEntityName:entityName
                                         predicate:nil
                                 saveAfterDeletion:YES
                              managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (void) deleteEntriesForEntityName:(NSString *)entityName
                  saveAfterDeletion:(BOOL)saveAfterDeletion
{
    [CDSDeletionService deleteEntriesForEntityName:entityName
                                         predicate:nil
                                 saveAfterDeletion:saveAfterDeletion
                              managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (void) deleteEntriesForEntityClass:(Class)entityClass
{
    [CDSDeletionService deleteEntriesForEntityName:NSStringFromClass(entityClass)
                                         predicate:nil
                                 saveAfterDeletion:YES
                              managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (void) deleteEntriesForEntityClass:(Class)entityClass
                   saveAfterDeletion:(BOOL)saveAfterDeletion
{
    [CDSDeletionService deleteEntriesForEntityName:NSStringFromClass(entityClass)
                                         predicate:nil
                                 saveAfterDeletion:saveAfterDeletion
                              managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (void) deleteEntriesForEntityName:(NSString *)entityName
               managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    [CDSDeletionService deleteEntriesForEntityName:entityName
                                         predicate:nil
                                 saveAfterDeletion:YES
                              managedObjectContext:managedObjectContext];
}

+ (void) deleteEntriesForEntityName:(NSString *)entityName
                  saveAfterDeletion:(BOOL)saveAfterDeletion
               managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    [CDSDeletionService deleteEntriesForEntityName:entityName
                                         predicate:nil
                                 saveAfterDeletion:saveAfterDeletion
                              managedObjectContext:managedObjectContext];
}

+ (void) deleteEntriesForEntityClass:(Class)entityClass
                managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    [CDSDeletionService deleteEntriesForEntityName:NSStringFromClass(entityClass)
                                         predicate:nil
                                 saveAfterDeletion:YES
                              managedObjectContext:managedObjectContext];
}

+ (void) deleteEntriesForEntityClass:(Class)entityClass
                   saveAfterDeletion:(BOOL)saveAfterDeletion
                managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    [CDSDeletionService deleteEntriesForEntityName:NSStringFromClass(entityClass)
                                         predicate:nil
                                 saveAfterDeletion:saveAfterDeletion
                              managedObjectContext:managedObjectContext];
}

@end

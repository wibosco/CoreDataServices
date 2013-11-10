//
//  CDSRetrievalService.m
//  CoreDataServices
//
//  Created by William Boles on 11/03/2013.
//  Copyright (c) 2013 Boles. All rights reserved.
//

#import "CDSRetrievalService.h"

@implementation CDSRetrievalService

#pragma mark - Multiple retrieval

+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                                 predicate:(NSPredicate *)predicate
                                   orderBy:(NSString *)orderBy
                            ascendingOrder:(BOOL)ascending
                            fetchBatchSize:(NSUInteger)fetchBatchSize
                                fetchLimit:(NSUInteger)fetchLimit
                      managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSArray *entries = nil;
    
    if (![NSString isStringEmpty:entityName])
    {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
        
        if (predicate)
        {
            [request setPredicate:predicate];
        }
        
        if (orderBy)
        {
            NSSortDescriptor *dateSort = [[NSSortDescriptor alloc] initWithKey:orderBy ascending:ascending];
            [request setSortDescriptors:[[NSArray alloc] initWithObjects:dateSort, nil]];
        }
        
        if (fetchBatchSize > 0)
        {
            [request setFetchBatchSize:fetchBatchSize];
        }
        
        if (fetchLimit > 0)
        {
            [request setFetchLimit:fetchLimit];
        }
        
        NSError *error = nil;
        
        entries =  [managedObjectContext executeFetchRequest:request
                                                       error:&error];
        
        if (error)
        {
            NSLog(@"Error attempting to retrieve entries from table %@, pred %@, orderby %@, managedObjectContext %@, ascending %d: %@", entityName, predicate, orderBy, managedObjectContext, ascending, [error userInfo]);
        }
    }
    
    return entries;

}

+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
                                    orderBy:(NSString *)orderBy
                             ascendingOrder:(BOOL)ascending
                             fetchBatchSize:(NSUInteger)fetchBatchSize
                                 fetchLimit:(NSUInteger)fetchLimit
                       managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSRetrievalService retrieveEntriesForEntityName:NSStringFromClass(entityClass)
                                                   predicate:predicate
                                                     orderBy:orderBy
                                              ascendingOrder:ascending
                                              fetchBatchSize:0
                                                  fetchLimit:fetchLimit
                                        managedObjectContext:managedObjectContext];
}

+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                                 predicate:(NSPredicate *)predicate
                                   orderBy:(NSString *)orderBy
                            ascendingOrder:(BOOL)ascending
                            fetchBatchSize:(NSUInteger)fetchBatchSize
                      managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSRetrievalService retrieveEntriesForEntityName:entityName
                                                   predicate:predicate
                                                     orderBy:orderBy
                                              ascendingOrder:ascending
                                              fetchBatchSize:0
                                                  fetchLimit:0
                                        managedObjectContext:managedObjectContext];
}

+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
                                    orderBy:(NSString *)orderBy
                             ascendingOrder:(BOOL)ascending
                             fetchBatchSize:(NSUInteger)fetchBatchSize
                       managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSRetrievalService retrieveEntriesForEntityName:NSStringFromClass(entityClass)
                                                   predicate:predicate
                                                     orderBy:orderBy
                                              ascendingOrder:ascending
                                              fetchBatchSize:0
                                                  fetchLimit:0
                                        managedObjectContext:managedObjectContext];
}

+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                                 predicate:(NSPredicate *)predicate
                                   orderBy:(NSString *)orderBy
                            ascendingOrder:(BOOL)ascending
                      managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
   return [CDSRetrievalService retrieveEntriesForEntityName:entityName
                                                  predicate:predicate
                                                    orderBy:orderBy
                                             ascendingOrder:ascending
                                             fetchBatchSize:0
                                                 fetchLimit:0
                                       managedObjectContext:managedObjectContext];
}

+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
                                    orderBy:(NSString *)orderBy
                             ascendingOrder:(BOOL)ascending
                       managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSRetrievalService retrieveEntriesForEntityName:NSStringFromClass(entityClass)
                                                   predicate:predicate
                                                     orderBy:orderBy
                                              ascendingOrder:ascending
                                              fetchBatchSize:0
                                                  fetchLimit:0
                                        managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
{
    return [CDSRetrievalService retrieveEntriesForEntityName:NSStringFromClass(entityClass)
                                                   predicate:nil
                                                       orderBy:nil
                                                ascendingOrder:NO
                                              fetchBatchSize:0
                                          managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
{
    return [CDSRetrievalService retrieveEntriesForEntityName:entityName
                                                   predicate:nil
                                                     orderBy:nil
                                              ascendingOrder:NO
                                              fetchBatchSize:0
                                                  fetchLimit:0
                                        managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                            fetchBatchSize:(NSUInteger)fetchBatchSize
{
    return [CDSRetrievalService retrieveEntriesForEntityName:entityName
                                                   predicate:nil
                                                     orderBy:nil
                                              ascendingOrder:NO
                                              fetchBatchSize:fetchBatchSize
                                                  fetchLimit:0
                                        managedObjectContext:[CDSServiceManager managedObjectContext]];
}


+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                             fetchBatchSize:(NSUInteger)fetchBatchSize
{
    return [CDSRetrievalService retrieveEntriesForEntityName:NSStringFromClass(entityClass)
                                                   predicate:nil
                                                     orderBy:nil
                                              ascendingOrder:NO
                                              fetchBatchSize:fetchBatchSize
                                                  fetchLimit:0
                                        managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                                 predicate:(NSPredicate *)predicate
{
    
    return [CDSRetrievalService retrieveEntriesForEntityName:entityName
                                                   predicate:predicate
                                                     orderBy:nil
                                              ascendingOrder:NO
                                              fetchBatchSize:0
                                                  fetchLimit:0
                                        managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
{
    return [CDSRetrievalService retrieveEntriesForEntityName:NSStringFromClass(entityClass)
                                                   predicate:predicate
                                                     orderBy:nil
                                              ascendingOrder:NO
                                              fetchBatchSize:0
                                                  fetchLimit:0
                                        managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                                 predicate:(NSPredicate *)predicate
                            fetchBatchSize:(NSUInteger)fetchBatchSize
{
    return [CDSRetrievalService retrieveEntriesForEntityName:entityName
                                                   predicate:predicate
                                                     orderBy:nil
                                              ascendingOrder:NO
                                              fetchBatchSize:fetchBatchSize
                                                  fetchLimit:0
                                        managedObjectContext:[CDSServiceManager managedObjectContext]];
}


+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
                             fetchBatchSize:(NSUInteger)fetchBatchSize
{
    return [CDSRetrievalService retrieveEntriesForEntityName:NSStringFromClass(entityClass)
                                                   predicate:predicate
                                                     orderBy:nil
                                              ascendingOrder:NO
                                              fetchBatchSize:fetchBatchSize
                                                  fetchLimit:0
                                        managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                                   orderBy:(NSString *)orderBy
                            ascendingOrder:(BOOL)ascending
{
    return [CDSRetrievalService retrieveEntriesForEntityName:entityName
                                                   predicate:nil
                                                     orderBy:orderBy
                                              ascendingOrder:ascending
                                              fetchBatchSize:0
                                                  fetchLimit:0
                                        managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                    orderBy:(NSString *)orderBy
                             ascendingOrder:(BOOL)ascending
{
    return [CDSRetrievalService retrieveEntriesForEntityName:NSStringFromClass(entityClass)
                                                   predicate:nil
                                                     orderBy:orderBy
                                              ascendingOrder:ascending
                                              fetchBatchSize:0
                                                  fetchLimit:0
                                        managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                                   orderBy:(NSString *)orderBy
                            ascendingOrder:(BOOL)ascending
                            fetchBatchSize:(NSUInteger)fetchBatchSize
{
    return [CDSRetrievalService retrieveEntriesForEntityName:entityName
                                                   predicate:nil
                                                     orderBy:orderBy
                                              ascendingOrder:ascending
                                              fetchBatchSize:fetchBatchSize
                                                  fetchLimit:0
                                        managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                    orderBy:(NSString *)orderBy
                             ascendingOrder:(BOOL)ascending
                             fetchBatchSize:(NSUInteger)fetchBatchSize
{
    return [CDSRetrievalService retrieveEntriesForEntityName:NSStringFromClass(entityClass)
                                                   predicate:nil
                                                     orderBy:orderBy
                                              ascendingOrder:ascending
                                              fetchBatchSize:fetchBatchSize
                                                  fetchLimit:0
                                        managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                                 predicate:(NSPredicate *)predicate
                                   orderBy:(NSString *)orderBy
                            ascendingOrder:(BOOL)ascending
{
    return [CDSRetrievalService retrieveEntriesForEntityName:entityName
                                                   predicate:predicate
                                                     orderBy:orderBy
                                              ascendingOrder:ascending
                                              fetchBatchSize:0
                                                  fetchLimit:0
                                        managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
                                    orderBy:(NSString *)orderBy
                             ascendingOrder:(BOOL)ascending
{
    return [CDSRetrievalService retrieveEntriesForEntityName:NSStringFromClass(entityClass)
                                                   predicate:predicate
                                                     orderBy:orderBy
                                              ascendingOrder:ascending
                                              fetchBatchSize:0
                                                  fetchLimit:0
                                        managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                                 predicate:(NSPredicate *)predicate
                                   orderBy:(NSString *)orderBy
                            ascendingOrder:(BOOL)ascending
                            fetchBatchSize:(NSUInteger)fetchBatchSize
{
    return [CDSRetrievalService retrieveEntriesForEntityName:entityName
                                                   predicate:predicate
                                                     orderBy:orderBy
                                              ascendingOrder:ascending
                                              fetchBatchSize:fetchBatchSize
                                                  fetchLimit:0
                                        managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
                                    orderBy:(NSString *)orderBy
                             ascendingOrder:(BOOL)ascending
                             fetchBatchSize:(NSUInteger)fetchBatchSize
{
    return [CDSRetrievalService retrieveEntriesForEntityName:NSStringFromClass(entityClass)
                                                   predicate:predicate
                                                     orderBy:orderBy
                                              ascendingOrder:ascending
                                              fetchBatchSize:fetchBatchSize
                                                  fetchLimit:0
                                        managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                      managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSRetrievalService retrieveEntriesForEntityName:entityName
                                                   predicate:nil
                                                     orderBy:nil
                                              ascendingOrder:NO
                                              fetchBatchSize:0
                                                  fetchLimit:0
                                        managedObjectContext:managedObjectContext];
}

+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                       managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSRetrievalService retrieveEntriesForEntityName:NSStringFromClass(entityClass)
                                                   predicate:nil
                                                     orderBy:nil
                                              ascendingOrder:NO
                                              fetchBatchSize:0
                                                  fetchLimit:0
                                        managedObjectContext:managedObjectContext];
}

+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                            fetchBatchSize:(NSUInteger)fetchBatchSize
                      managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSRetrievalService retrieveEntriesForEntityName:entityName
                                                   predicate:nil
                                                     orderBy:nil
                                              ascendingOrder:NO
                                              fetchBatchSize:fetchBatchSize
                                                  fetchLimit:0
                                        managedObjectContext:managedObjectContext];
}

+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                             fetchBatchSize:(NSUInteger)fetchBatchSize
                       managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSRetrievalService retrieveEntriesForEntityName:NSStringFromClass(entityClass)
                                                   predicate:nil
                                                     orderBy:nil
                                              ascendingOrder:NO
                                              fetchBatchSize:fetchBatchSize
                                                  fetchLimit:0
                                        managedObjectContext:managedObjectContext];
}

+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                                 predicate:(NSPredicate *)predicate
                      managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSRetrievalService retrieveEntriesForEntityName:entityName
                                                   predicate:predicate
                                                     orderBy:nil
                                              ascendingOrder:NO
                                              fetchBatchSize:0
                                                  fetchLimit:0
                                        managedObjectContext:managedObjectContext];
}

+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
                       managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSRetrievalService retrieveEntriesForEntityName:NSStringFromClass(entityClass)
                                                   predicate:predicate
                                                     orderBy:nil
                                              ascendingOrder:NO
                                              fetchBatchSize:0
                                                  fetchLimit:0
                                        managedObjectContext:managedObjectContext];
}

+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                                 predicate:(NSPredicate *)predicate
                            fetchBatchSize:(NSUInteger)fetchBatchSize
                      managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSRetrievalService retrieveEntriesForEntityName:entityName
                                                   predicate:predicate
                                                     orderBy:nil
                                              ascendingOrder:NO
                                              fetchBatchSize:0
                                                  fetchLimit:0
                                        managedObjectContext:managedObjectContext];
}

+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
                             fetchBatchSize:(NSUInteger)fetchBatchSize
                       managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSRetrievalService retrieveEntriesForEntityName:NSStringFromClass(entityClass)
                                                   predicate:predicate
                                                     orderBy:nil
                                              ascendingOrder:NO
                                              fetchBatchSize:0
                                                  fetchLimit:0
                                        managedObjectContext:managedObjectContext];
}

#pragma mark - Single retrieval

+ (id) retrieveFirstEntryForEntityName:(NSString *)entityName
                             predicate:(NSPredicate *)predicate
                               orderBy:(NSString *)orderBy
                        ascendingOrder:(BOOL)ascending
                  managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    
    NSManagedObject *managedObject = nil;
    
    NSArray *managedObjects = [CDSRetrievalService retrieveEntriesForEntityName:entityName
                                                                      predicate:predicate
                                                                        orderBy:orderBy
                                                                 ascendingOrder:ascending
                                                                 fetchBatchSize:0
                                                                     fetchLimit:1
                                                           managedObjectContext:managedObjectContext];
    
    
    if ([managedObjects count] > 0)
    {
        managedObject = [managedObjects objectAtIndex:0];
    }
    
    return managedObject;
    
}

+ (id) retrieveFirstEntryForEntityClass:(Class)entityClass
                              predicate:(NSPredicate *)predicate
                                orderBy:(NSString *)orderBy
                         ascendingOrder:(BOOL)ascending
                   managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSRetrievalService retrieveFirstEntryForEntityName:NSStringFromClass(entityClass)
                                                      predicate:predicate
                                                        orderBy:orderBy
                                                 ascendingOrder:ascending
                                           managedObjectContext:[CDSServiceManager managedObjectContext]];
}


+ (id) retrieveFirstEntryForEntityName:(NSString *)entityName
{
    return [CDSRetrievalService retrieveFirstEntryForEntityName:entityName
                                                      predicate:nil
                                                        orderBy:nil
                                                 ascendingOrder:NO
                                           managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (id) retrieveFirstEntryForEntityClass:(Class)entityClass
{
    return [CDSRetrievalService retrieveFirstEntryForEntityName:NSStringFromClass(entityClass)
                                                      predicate:nil
                                                        orderBy:nil
                                                 ascendingOrder:NO
                                           managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (id) retrieveFirstEntryForEntityName:(NSString *)entityName
                  managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSRetrievalService retrieveFirstEntryForEntityName:entityName
                                       predicate:nil
                                         orderBy:nil
                                  ascendingOrder:NO
                            managedObjectContext:managedObjectContext];
}

+ (id) retrieveFirstEntryForEntityClass:(Class)entityClass
                   managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSRetrievalService retrieveFirstEntryForEntityName:NSStringFromClass(entityClass)
                                       predicate:nil
                                         orderBy:nil
                                  ascendingOrder:NO
                            managedObjectContext:managedObjectContext];
}

+ (id) retrieveFirstEntryForEntityName:(NSString *)entityName
                             predicate:(NSPredicate *)predicate
                               orderBy:(NSString *)orderBy
                        ascendingOrder:(BOOL)ascending
{
    return [CDSRetrievalService retrieveFirstEntryForEntityName:entityName
                                                      predicate:predicate
                                                        orderBy:orderBy
                                                 ascendingOrder:ascending
                                           managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (id) retrieveFirstEntryForEntityClass:(Class)entityClass
                              predicate:(NSPredicate *)predicate
                                orderBy:(NSString *)orderBy
                         ascendingOrder:(BOOL)ascending
{
    return [CDSRetrievalService retrieveFirstEntryForEntityName:NSStringFromClass(entityClass)
                                                      predicate:predicate
                                                        orderBy:orderBy
                                                 ascendingOrder:ascending
                                           managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (id) retrieveFirstEntryForEntityName:(NSString *)entityName
                             predicate:(NSPredicate *)predicate
{
    
    return [CDSRetrievalService retrieveFirstEntryForEntityName:entityName
                                                      predicate:predicate
                                                        orderBy:nil
                                                 ascendingOrder:NO
                                           managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (id) retrieveFirstEntryForEntityClass:(Class)entityClass
                              predicate:(NSPredicate *)predicate
{
    return [CDSRetrievalService retrieveFirstEntryForEntityName:NSStringFromClass(entityClass)
                                                      predicate:predicate
                                                        orderBy:nil
                                                 ascendingOrder:NO
                                           managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (id) retrieveFirstEntryForEntityName:(NSString *)entityName
                             predicate:(NSPredicate *)predicate
                  managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    
    return [CDSRetrievalService retrieveFirstEntryForEntityName:entityName
                                                      predicate:predicate
                                                       orderBy:nil
                                                ascendingOrder:NO
                                          managedObjectContext:managedObjectContext];
    
}

+ (id) retrieveFirstEntryForEntityClass:(Class)entityClass
                              predicate:(NSPredicate *)predicate
                   managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    
    return [CDSRetrievalService retrieveFirstEntryForEntityName:NSStringFromClass(entityClass)
                                                      predicate:predicate
                                                       orderBy:nil
                                                ascendingOrder:NO
                                          managedObjectContext:managedObjectContext];
    
}

@end

//
//  CDSRetrievalService.m
//  CoreDataServices
//
//  Created by William Boles on 15/04/2014.
//  Copyright (c) 2014 Boles. All rights reserved.
//

#import "CDSRetrievalService.h"

#import "CDSServiceManager.h"
#import "NSFetchRequest+CDSFetchRequest.h"

@implementation CDSRetrievalService

#pragma mark - MultipleRetrieval

+ (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
                                 predicate:(NSPredicate *)predicate
                           sortDescriptors:(NSArray *)sortDescriptors
                            fetchBatchSize:(NSUInteger)fetchBatchSize
                                fetchLimit:(NSUInteger)fetchLimit
                      managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSArray *entries = nil;
    
    NSString *entityName = NSStringFromClass(entityClass);
    
    if (entityName.length > 0)
    {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityClass:entityClass];
        
        if (predicate)
        {
            request.predicate = predicate;
        }
        
        if (sortDescriptors.count > 0)
        {
            request.sortDescriptors = sortDescriptors;
        }
        
        if (fetchBatchSize > 0)
        {
            request.fetchBatchSize = fetchBatchSize;
        }
        
        if (fetchLimit > 0)
        {
            request.fetchLimit = fetchLimit;
        }
        
        NSError *error = nil;
        
        @try
        {
            entries =  [managedObjectContext executeFetchRequest:request
                                                           error:&error];
        }
        @catch (NSException *exception)
        {
            //CoreData doesn't give us nice logs on exceptions so we have to log it out manually here.
            NSLog(@"** COREDATA EXCEPTION ** : %@", [exception description]);
            abort();
        }
        
        if (error)
        {
            NSLog(@"Error attempting to retrieve entries from table %@, pred %@, sortDescriptors %@, managedObjectContext %@, userinfo: %@", entityName, predicate, sortDescriptors, managedObjectContext, [error userInfo]);
        }
    }
    
    return entries;
}

+ (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
                                 predicate:(NSPredicate *)predicate
                           sortDescriptors:(NSArray *)sortDescriptors
                            fetchBatchSize:(NSUInteger)fetchBatchSize
                      managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSRetrievalService retrieveEntriesForEntityClass:entityClass
                                                    predicate:predicate
                                              sortDescriptors:sortDescriptors
                                               fetchBatchSize:0
                                                   fetchLimit:0
                                         managedObjectContext:managedObjectContext];
}

+ (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
                                 predicate:(NSPredicate *)predicate
                           sortDescriptors:(NSArray *)sortDescriptors
                      managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSRetrievalService retrieveEntriesForEntityClass:entityClass
                                                    predicate:predicate
                                              sortDescriptors:sortDescriptors
                                               fetchBatchSize:0
                                                   fetchLimit:0
                                         managedObjectContext:[CDSServiceManager sharedInstance].managedObjectContext];
}

+ (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
{
    return [CDSRetrievalService retrieveEntriesForEntityClass:entityClass
                                                    predicate:nil
                                              sortDescriptors:nil
                                               fetchBatchSize:0
                                         managedObjectContext:[CDSServiceManager sharedInstance].managedObjectContext];
}


+ (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
                            fetchBatchSize:(NSUInteger)fetchBatchSize
{
    return [CDSRetrievalService retrieveEntriesForEntityClass:entityClass
                                                    predicate:nil
                                              sortDescriptors:nil
                                               fetchBatchSize:fetchBatchSize
                                                   fetchLimit:0
                                         managedObjectContext:[CDSServiceManager sharedInstance].managedObjectContext];
}

+ (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
                                 predicate:(NSPredicate *)predicate
{
    return [CDSRetrievalService retrieveEntriesForEntityClass:entityClass
                                                    predicate:predicate
                                              sortDescriptors:nil
                                               fetchBatchSize:0
                                                   fetchLimit:0
                                         managedObjectContext:[CDSServiceManager sharedInstance].managedObjectContext];
}

+ (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
                                 predicate:(NSPredicate *)predicate
                            fetchBatchSize:(NSUInteger)fetchBatchSize
{
    return [CDSRetrievalService retrieveEntriesForEntityClass:entityClass
                                                    predicate:predicate
                                              sortDescriptors:nil
                                               fetchBatchSize:fetchBatchSize
                                                   fetchLimit:0
                                         managedObjectContext:[CDSServiceManager sharedInstance].managedObjectContext];
}

+ (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
                           sortDescriptors:(NSArray *)sortDescriptors
{
    return [CDSRetrievalService retrieveEntriesForEntityClass:entityClass
                                                    predicate:nil
                                              sortDescriptors:sortDescriptors
                                               fetchBatchSize:0
                                                   fetchLimit:0
                                         managedObjectContext:[CDSServiceManager sharedInstance].managedObjectContext];
}

+ (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
                           sortDescriptors:(NSArray *)sortDescriptors
                            fetchBatchSize:(NSUInteger)fetchBatchSize
{
    return [CDSRetrievalService retrieveEntriesForEntityClass:entityClass
                                                    predicate:nil
                                              sortDescriptors:sortDescriptors
                                               fetchBatchSize:fetchBatchSize
                                                   fetchLimit:0
                                         managedObjectContext:[CDSServiceManager sharedInstance].managedObjectContext];
}

+ (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
                                 predicate:(NSPredicate *)predicate
                           sortDescriptors:(NSArray *)sortDescriptors
{
    return [CDSRetrievalService retrieveEntriesForEntityClass:entityClass
                                                    predicate:predicate
                                              sortDescriptors:sortDescriptors
                                               fetchBatchSize:0
                                                   fetchLimit:0
                                         managedObjectContext:[CDSServiceManager sharedInstance].managedObjectContext];
}

+ (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
                                 predicate:(NSPredicate *)predicate
                           sortDescriptors:(NSArray *)sortDescriptors
                            fetchBatchSize:(NSUInteger)fetchBatchSize
{
    return [CDSRetrievalService retrieveEntriesForEntityClass:entityClass
                                                    predicate:predicate
                                              sortDescriptors:sortDescriptors
                                               fetchBatchSize:fetchBatchSize
                                                   fetchLimit:0
                                         managedObjectContext:[CDSServiceManager sharedInstance].managedObjectContext];
}

+ (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
                      managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSRetrievalService retrieveEntriesForEntityClass:entityClass
                                                    predicate:nil
                                              sortDescriptors:nil
                                               fetchBatchSize:0
                                                   fetchLimit:0
                                         managedObjectContext:managedObjectContext];
}

+ (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
                            fetchBatchSize:(NSUInteger)fetchBatchSize
                      managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSRetrievalService retrieveEntriesForEntityClass:entityClass
                                                    predicate:nil
                                              sortDescriptors:nil
                                               fetchBatchSize:fetchBatchSize
                                                   fetchLimit:0
                                         managedObjectContext:managedObjectContext];
}

+ (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
                                 predicate:(NSPredicate *)predicate
                      managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSRetrievalService retrieveEntriesForEntityClass:entityClass
                                                    predicate:predicate
                                              sortDescriptors:nil
                                               fetchBatchSize:0
                                                   fetchLimit:0
                                         managedObjectContext:managedObjectContext];
}

+ (NSArray *)retrieveEntriesForEntityClass:(Class)entityClass
                                 predicate:(NSPredicate *)predicate
                            fetchBatchSize:(NSUInteger)fetchBatchSize
                      managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSRetrievalService retrieveEntriesForEntityClass:entityClass
                                                    predicate:predicate
                                              sortDescriptors:nil
                                               fetchBatchSize:0
                                                   fetchLimit:0
                                         managedObjectContext:managedObjectContext];
}

#pragma mark - SingleRetrieval

+ (id)retrieveFirstEntryForEntityClass:(Class)entityClass
                             predicate:(NSPredicate *)predicate
                       sortDescriptors:(NSArray *)sortDescriptors
                  managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSManagedObject *entry = nil;
    
    NSArray *entries = [CDSRetrievalService retrieveEntriesForEntityClass:entityClass
                                                                predicate:predicate
                                                          sortDescriptors:sortDescriptors
                                                           fetchBatchSize:0
                                                               fetchLimit:1
                                                     managedObjectContext:managedObjectContext];
    
    
    if (entries.count > 0)
    {
        entry = entries[0];
    }
    
    return entry;
}

+ (id)retrieveFirstEntryForEntityClass:(Class)entityClass
{
    return [CDSRetrievalService retrieveFirstEntryForEntityClass:entityClass
                                                       predicate:nil
                                                 sortDescriptors:nil
                                            managedObjectContext:[CDSServiceManager sharedInstance].managedObjectContext];
}

+ (id)retrieveFirstEntryForEntityClass:(Class)entityClass
                  managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSRetrievalService retrieveFirstEntryForEntityClass:entityClass
                                                       predicate:nil
                                                 sortDescriptors:nil
                                            managedObjectContext:managedObjectContext];
}

+ (id)retrieveFirstEntryForEntityClass:(Class)entityClass
                             predicate:(NSPredicate *)predicate
                       sortDescriptors:(NSArray *)sortDescriptors
{
    return [CDSRetrievalService retrieveFirstEntryForEntityClass:entityClass
                                                       predicate:predicate
                                                 sortDescriptors:sortDescriptors
                                            managedObjectContext:[CDSServiceManager sharedInstance].managedObjectContext];
}

+ (id)retrieveFirstEntryForEntityClass:(Class)entityClass
                             predicate:(NSPredicate *)predicate
{
    return [CDSRetrievalService retrieveFirstEntryForEntityClass:entityClass
                                                       predicate:predicate
                                                 sortDescriptors:nil
                                            managedObjectContext:[CDSServiceManager sharedInstance].managedObjectContext];
}

+ (id)retrieveFirstEntryForEntityClass:(Class)entityClass
                             predicate:(NSPredicate *)predicate
                  managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    
    return [CDSRetrievalService retrieveFirstEntryForEntityClass:entityClass
                                                       predicate:predicate
                                                 sortDescriptors:nil
                                            managedObjectContext:managedObjectContext];
    
}

@end

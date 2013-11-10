//
//  CDSCountService.m
//  CoreDataServices
//
//  Created by William Boles on 11/03/2013.
//  Copyright (c) 2013 Boles. All rights reserved.
//

#import "CDSCountService.h"

@implementation CDSCountService

#pragma mark - Count

+ (NSUInteger) retrieveEntriesCountForEntityName:(NSString *)entityName
                                       predicate:(NSPredicate *)predicate
                            managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    
    NSUInteger count = 0;
    
    if (![NSString isStringEmpty:entityName])
    {
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
        
        if (predicate)
        {
           [request setPredicate:predicate]; 
        }
        
        NSError *error = nil;
        
        count = [managedObjectContext countForFetchRequest:request
                                                     error:&error];
        
        if (error)
        {
            NSLog(@"Error attempting to retrieve entries count from table %@ with pred %@: %@", entityName, predicate, [error userInfo]);
        }
        
    }
    
    return count;
}

+ (NSUInteger) retrieveEntriesCountForEntityName:(NSString *)entityName
{
    return [CDSCountService retrieveEntriesCountForEntityName:entityName
                                                    predicate:nil
                                         managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (NSUInteger) retrieveEntriesCountForEntityClass:(Class)entityClass
{
    return [CDSCountService retrieveEntriesCountForEntityName:NSStringFromClass(entityClass)
                                                    predicate:nil
                                         managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (NSUInteger) retrieveEntriesCountForEntityName:(NSString *)entityName
                            managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSCountService retrieveEntriesCountForEntityName:entityName
                                                    predicate:nil
                                         managedObjectContext:managedObjectContext];
}

+ (NSUInteger) retrieveEntriesCountForEntityClass:(Class)entityClass
                             managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSCountService retrieveEntriesCountForEntityName:NSStringFromClass(entityClass)
                                                    predicate:nil
                                         managedObjectContext:managedObjectContext];
}

+ (NSUInteger) retrieveEntriesCountForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
                             managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSCountService retrieveEntriesCountForEntityName:NSStringFromClass(entityClass)
                                                    predicate:predicate
                                            managedObjectContext:managedObjectContext];
}

+ (NSUInteger) retrieveEntriesCountForEntityName:(NSString *)entityName
                                 predicate:(NSPredicate *)predicate
{
    return [CDSCountService retrieveEntriesCountForEntityName:entityName
                                                    predicate:predicate
                                            managedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (NSUInteger) retrieveEntriesCountForEntityClass:(Class)entityClass
                                        predicate:(NSPredicate *)predicate
{
    return [CDSCountService retrieveEntriesCountForEntityName:NSStringFromClass(entityClass)
                                                    predicate:predicate
                                         managedObjectContext:[CDSServiceManager managedObjectContext]];
}

@end

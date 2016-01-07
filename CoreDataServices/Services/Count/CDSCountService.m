//
//  CDSCountService.m
//  CoreDataServices
//
//  Created by William Boles on 11/03/2013.
//  Copyright (c) 2013 Boles. All rights reserved.
//

#import "CDSCountService.h"

#import "CDSServiceManager.h"

@implementation CDSCountService

#pragma mark - Count

+ (NSUInteger)retrieveEntriesCountForEntityClass:(Class)entityClass
                                        predicate:(NSPredicate *)predicate
                             managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSUInteger count = 0;
    
    NSString *entityName = NSStringFromClass(entityClass);
    
    if (entityName.length > 0)
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

+ (NSUInteger)retrieveEntriesCountForEntityClass:(Class)entityClass
                                        predicate:(NSPredicate *)predicate
{
    return [CDSCountService retrieveEntriesCountForEntityClass:entityClass
                                                     predicate:predicate
                                          managedObjectContext:[CDSServiceManager sharedInstance].managedObjectContext];
}

+ (NSUInteger)retrieveEntriesCountForEntityClass:(Class)entityClass
                             managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [CDSCountService retrieveEntriesCountForEntityClass:entityClass
                                                     predicate:nil
                                          managedObjectContext:managedObjectContext];
}

+ (NSUInteger)retrieveEntriesCountForEntityClass:(Class)entityClass
{
    return [CDSCountService retrieveEntriesCountForEntityClass:entityClass
                                                     predicate:nil
                                          managedObjectContext:[CDSServiceManager sharedInstance].managedObjectContext];
}

@end

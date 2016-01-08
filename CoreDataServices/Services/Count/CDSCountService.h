//
//  CDSCountService.h
//  CoreDataServices
//
//  Created by William Boles on 11/03/2013.
//  Copyright (c) 2013 Boles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CDSCountService : NSObject

/*
 Retrieves the count of entries from default context
 
 @param entityClass - a class value for the entity in core data
 
 @return count
 */
+ (NSUInteger)retrieveEntriesCountForEntityClass:(Class)entityClass;

/*
 Retrieves the count of entries from specfic context
 
 @param entityClass - a class value for the entity in core data
 @param managedObjectContext - the context used to access the entries
 
 @return count
 */
+ (NSUInteger)retrieveEntriesCountForEntityClass:(Class)entityClass
                            managedObjectContext:(NSManagedObjectContext *)managedObjectContext;


/*
 Retrieves the count of entries that match the provided predicate's conditions from default context
 
 @param entityClass - a class value for the entity in core data
 @param predicate - a predicate used to limit the entries returned
 
 @return count
 */
+ (NSUInteger)retrieveEntriesCountForEntityClass:(Class)entityClass
                                       predicate:(NSPredicate *)predicate;

/*
 Retrieves the count of entries that match the provided predicate's conditions from specfic context
 
 @param entityClass - a class value for the entity in core data
 @param predicate - a predicate used to limit the entries returned
 @param managedObjectContext - the context used to access the entries
 
 @return count
 */
+ (NSUInteger)retrieveEntriesCountForEntityClass:(Class)entityClass
                                       predicate:(NSPredicate *)predicate
                            managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end

//
//  NSManagedObjectContext+CDSCount.h
//  CoreDataServices
//
//  Created by William Boles on 08/01/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (CDSCount)

/*
 Retrieves the count of entries 
 
 @param entityClass - a class value for the entity in core data
 
 @return count of entries for this class/entity
 */
- (NSUInteger)retrieveEntriesCountForEntityClass:(Class)entityClass;


/*
 Retrieves the count of entries that match the provided predicate's conditions 
 
 @param entityClass - a class value for the entity in core data
 @param predicate - a predicate used to limit the entries returned
 
 @return count of entries that match provided predicate
 */
- (NSUInteger)retrieveEntriesCountForEntityClass:(Class)entityClass
                                       predicate:(NSPredicate *)predicate;


@end

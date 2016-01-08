//
//  NSManagedObjectContext+CDSDelete.h
//  CoreDataServices
//
//  Created by William Boles on 08/01/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (CDSDelete)

#pragma mark - Deletion

/*
 Deletes an nsmanagedobject 
 
 @param managedObject - to be deleted
 */
- (void)deleteManagedObject:(NSManagedObject *)managedObject;

/*
 Deletes an nsmanagedobject 
 
 @param managedObject - to be deleted
 @param saveAfterDeletion - used to determine if after deletion the managed object context should be saved
 */
- (void)deleteManagedObject:(NSManagedObject *)managedObject
          saveAfterDeletion:(BOOL)saveAfterDeletion;

/*
 Deletes entites 
 
 @param entityClass - a class value for the entity in core data
 */
- (void)deleteEntriesForEntityClass:(Class)entityClass;

/*
 Deletes entites 
 
 @param entityClass - a class value for the entity in core data
 @param saveAfterDeletion - used to determine if after deletion the managed object context should be saved
 */
- (void)deleteEntriesForEntityClass:(Class)entityClass
                  saveAfterDeletion:(BOOL)saveAfterDeletion;

/*
 Deletes entites that match the predicate 
 
 @param entityClass - a class value for the entity in core data
 @param predicate - a predicate used to limit the entries deleted
 */
- (void)deleteEntriesForEntityClass:(Class)entityClass
                          predicate:(NSPredicate *)predicate;

/*
 Deletes entites that match the predicate 
 
 @param entityClass - a class value for the entity in core data
 @param predicate - a predicate used to limit the entries deleted
 @param saveAfterDeletion - used to determine if after deletion the managed object context should be saved
 */
- (void)deleteEntriesForEntityClass:(Class)entityClass
                          predicate:(NSPredicate *)predicate
                  saveAfterDeletion:(BOOL)saveAfterDeletion;


@end

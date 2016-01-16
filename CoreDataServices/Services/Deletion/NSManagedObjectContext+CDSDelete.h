//
//  NSManagedObjectContext+CDSDelete.h
//  CoreDataServices
//
//  Created by William Boles on 08/01/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

@import CoreData;

/**
 A category that extends `NSManagedObjectContext` to provide convenience methods related to deleting entries/rows/objects in your Core Data Entity.
 
 In order to use this category you will need to create a subclasses of `NSManagedObject` rather than using KVO.
 */
@interface NSManagedObjectContext (CDSDelete)

/*
 Deletes an nsmanagedobject.
 
 @param managedObject - to be deleted.
 */
- (void)cds_deleteManagedObject:(NSManagedObject *)managedObject;

/*
 Deletes an nsmanagedobject.
 
 @param managedObject - to be deleted.
 @param saveAfterDeletion - used to determine if after deletion the managed object context should be saved.
 */
- (void)cds_deleteManagedObject:(NSManagedObject *)managedObject
              saveAfterDeletion:(BOOL)saveAfterDeletion;

/*
 Deletes entites.
 
 @param entityClass - a class value for the entity in core data.
 */
- (void)cds_deleteEntriesForEntityClass:(Class)entityClass;

/*
 Deletes entites.
 
 @param entityClass - a class value for the entity in core data.
 @param saveAfterDeletion - used to determine if after deletion the managed object context should be saved.
 */
- (void)cds_deleteEntriesForEntityClass:(Class)entityClass
                      saveAfterDeletion:(BOOL)saveAfterDeletion;

/*
 Deletes entites that match the predicate.
 
 @param entityClass - a class value for the entity in core data.
 @param predicate - a predicate used to limit the entries deleted.
 */
- (void)cds_deleteEntriesForEntityClass:(Class)entityClass
                              predicate:(NSPredicate *)predicate;

/*
 Deletes entites that match the predicate.
 
 @param entityClass - a class value for the entity in core data.
 @param predicate - a predicate used to limit the entries deleted.
 @param saveAfterDeletion - used to determine if after deletion the managed object context should be saved.
 */
- (void)cds_deleteEntriesForEntityClass:(Class)entityClass
                              predicate:(NSPredicate *)predicate
                      saveAfterDeletion:(BOOL)saveAfterDeletion;


@end

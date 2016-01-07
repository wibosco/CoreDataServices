//
//  CDSDeletionService.h
//  CoreDataServices
//
//  Created by William Boles on 11/03/2013.
//  Copyright (c) 2013 Boles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CDSDeletionService : NSObject

#pragma mark - Deletion

/*
 Deletes an nsmanagedobject from default context
 
 @param managedObject to be deleted
 */
+ (void)deleteManagedObject:(NSManagedObject *)managedObject;

/*
 Deletes an nsmanagedobject from default context
 
 @param managedObject to be deleted
 @param saveAfterDeletion used to determine if after deletion the managed object context should be saved
 */
+ (void)deleteManagedObject:(NSManagedObject *)managedObject
          saveAfterDeletion:(BOOL)saveAfterDeletion;

/*
 Deletes an nsmanagedobject from specfic context
 
 @param managedObject to be deleted
 @param managedObjectContext the context used to access the entries
 */
+ (void)deleteManagedObject:(NSManagedObject *)managedObject
       managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/*
 Deletes an nsmanagedobject from specfic context
 
 @param managedObject to be deleted
 @param saveAfterDeletion used to determine if after deletion the managed object context should be saved
 @param managedObjectContext the context used to access the entries
 */
+ (void)deleteManagedObject:(NSManagedObject *)managedObject
          saveAfterDeletion:(BOOL)saveAfterDeletion
       managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/*
 Deletes entites from default context
 
 @param entityClass a class value for the entity in core data
 */
+ (void)deleteEntriesForEntityClass:(Class)entityClass;

/*
 Deletes entites from default context
 
 @param entityClass a class value for the entity in core data
 @param saveAfterDeletion used to determine if after deletion the managed object context should be saved
 */
+ (void)deleteEntriesForEntityClass:(Class)entityClass
                  saveAfterDeletion:(BOOL)saveAfterDeletion;


/*
 Deletes entites from specfic context
 
 @param entityClass a class value for the entity in core data
 @param managedObjectContext the context used to access the entries
 */
+ (void)deleteEntriesForEntityClass:(Class)entityClass
               managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/*
 Deletes entites from specfic context
 
 @param entityClass a class value for the entity in core data
 @param saveAfterDeletion used to determine if after deletion the managed object context should be saved
 @param managedObjectContext the context used to access the entries
 */
+ (void)deleteEntriesForEntityClass:(Class)entityClass
                  saveAfterDeletion:(BOOL)saveAfterDeletion
               managedObjectContext:(NSManagedObjectContext *)managedObjectContext;


/*
 Deletes entites that match the predicate from default context
 
 @param entityClass a class value for the entity in core data
 @param predicate a predicate used to limit the entries deleted
 */
+ (void)deleteEntriesForEntityClass:(Class)entityClass
                          predicate:(NSPredicate *)predicate;

/*
 Deletes entites that match the predicate from default context
 
 @param entityClass a class value for the entity in core data
 @param predicate a predicate used to limit the entries deleted
 @param saveAfterDeletion used to determine if after deletion the managed object context should be saved
 */
+ (void)deleteEntriesForEntityClass:(Class)entityClass
                          predicate:(NSPredicate *)predicate
                  saveAfterDeletion:(BOOL)saveAfterDeletion;

/*
 Deletes entites that match the predicate from specfic context
 
 @param entityClass a class value for the entity in core data
 @param predicate a predicate used to limit the entries deleted
 @param managedObjectContext the context used to access the entries
 */
+ (void)deleteEntriesForEntityClass:(Class)entityClass
                          predicate:(NSPredicate *)predicate
               managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/*
 Deletes entites that match the predicate from specfic context
 
 @param entityClass a class value for the entity in core data
 @param predicate a predicate used to limit the entries deleted
 @param saveAfterDeletion used to determine if after deletion the managed object context should be saved
 @param managedObjectContext the context used to access the entries
 */
+ (void)deleteEntriesForEntityClass:(Class)entityClass
                          predicate:(NSPredicate *)predicate
                  saveAfterDeletion:(BOOL)saveAfterDeletion
               managedObjectContext:(NSManagedObjectContext *)managedObjectContext;




@end

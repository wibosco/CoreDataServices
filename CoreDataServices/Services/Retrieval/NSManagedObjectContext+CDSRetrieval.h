//
//  NSManagedObjectContext+CDSRetrieval.h
//  CoreDataServices
//
//  Created by William Boles on 08/01/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (CDSRetrieval)

/*
 Retrieves all entries for an entity in core data
 
 @param entityClass - a class value for the entity in core data
 
 @return an array of NSManagedObjects
 */
- (NSArray *)cds_retrieveEntriesForEntityClass:(Class)entityClass;

/*
 Retrieves all entries for an entity in core data
 
 @param entityClass - a class value for the entity in core data
 @param fetchBatchSize - limits the number of returned objects in each batch
 
 @return an array of NSManagedObjects
 */
- (NSArray *)cds_retrieveEntriesForEntityClass:(Class)entityClass
                                fetchBatchSize:(NSUInteger)fetchBatchSize;


/*
 Retrieves all entries for an entity in core data that match the provided predicate's conditions
 
 @param entityClass - a class value for the entity in core data
 @param predicate - a predicate used to limit the entries returned
 
 @return an array of NSManagedObjects
 */
- (NSArray *)cds_retrieveEntriesForEntityClass:(Class)entityClass
                                     predicate:(NSPredicate *)predicate;


/*
 Retrieves all entries for an entity in core data that match the provided predicate's conditions
 
 @param entityClass - a class value for the entity in core data
 @param predicate - a predicate used to limit the entries returned
 @param fetchBatchSize - limits the number of returned objects in each batch
 
 @return an array of NSManagedObjects
 */
- (NSArray *)cds_retrieveEntriesForEntityClass:(Class)entityClass
                                     predicate:(NSPredicate *)predicate
                                fetchBatchSize:(NSUInteger)fetchBatchSize;


/*
 Retrieves ordered entries for an entity in core data
 
 @param entityClass - a class value for the entity in core data
 @param sortDescriptors - an array containing sorting values to be applied to this request
 
 @return an array of NSManagedObjects
 */
- (NSArray *)cds_retrieveEntriesForEntityClass:(Class)entityClass
                               sortDescriptors:(NSArray *)sortDescriptors;


/*
 Retrieves ordered entries for an entity in core data
 
 @param entityClass - a class value for the entity in core data
 @param sortDescriptors - an array containing sorting values to be applied to this request
 @param fetchBatchSize - limits the number of returned objects in each batch
 
 @return an array of NSManagedObjects
 */
- (NSArray *)cds_retrieveEntriesForEntityClass:(Class)entityClass
                               sortDescriptors:(NSArray *)sortDescriptors
                                fetchBatchSize:(NSUInteger)fetchBatchSize;


/*
 Retrieves ordered entries for an entity in core data that match the provided predicate's conditions
 
 @param entityClass - a class value for the entity in core data
 @param predicate - a predicate used to limit the entries returned
 @param sortDescriptors - an array containing sorting values to be applied to this request
 
 @return an array of NSManagedObjects
 */
- (NSArray *)cds_retrieveEntriesForEntityClass:(Class)entityClass
                                     predicate:(NSPredicate *)predicate
                               sortDescriptors:(NSArray *)sortDescriptors;


/*
 Retrieves ordered entries for an entity in core data that match the provided predicate's conditions
 
 @param entityClass - a class value for the entity in core data
 @param predicate - a predicate used to limit the entries returned
 @param sortDescriptors - an array containing sorting values to be applied to this request
 @param fetchBatchSize - limits the number of returned objects in each batch
 
 @return an array of NSManagedObjects
 */
- (NSArray *)cds_retrieveEntriesForEntityClass:(Class)entityClass
                                     predicate:(NSPredicate *)predicate
                               sortDescriptors:(NSArray *)sortDescriptors
                                fetchBatchSize:(NSUInteger)fetchBatchSize;


#pragma mark - SingleRetrieval

/*
 Retrieves first entry for an entity in core data
 
 @param entityClass - a class value for the entity in core data
 
 @return single instance of an NSManagedObject
 */
- (NSManagedObject *)cds_retrieveFirstEntryForEntityClass:(Class)entityClass;

/*
 Retrieves first entry for an entity in core data that match the provided predicate's conditions
 
 @param entityClass - a class value for the entity in core data
 @param predicate - a predicate used to limit the entries returned
 
 @return single instance of an NSManagedObject
 */
- (NSManagedObject *)cds_retrieveFirstEntryForEntityClass:(Class)entityClass
                                                predicate:(NSPredicate *)predicate;


/*
 Retrieves first entry for an entity in core data
 
 @param entityClass - a class value for the entity in core data
 @param predicate - a predicate used to limit the entries returned
 @param sortDescriptors - an array containing sorting values to be applied to this request
 
 @return single instance of an NSManagedObject
 */
- (NSManagedObject *)cds_retrieveFirstEntryForEntityClass:(Class)entityClass
                                                predicate:(NSPredicate *)predicate
                                          sortDescriptors:(NSArray *)sortDescriptors;


@end

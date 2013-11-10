//
//  CDSRetrievalService.h
//  CoreDataServices
//
//  Created by William Boles on 11/03/2013.
//  Copyright (c) 2013 Boles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDSRetrievalService : NSObject

/*
 Retrieves all entries for an entity in core data from default context
 
 @param entityName a string value for the entity in core data
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName;

/*
 Retrieves all entries for an entity in core data from default context
 
 @param entityClass a class value for the entity in core data
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass;

/*
 Retrieves all entries for an entity in core data from default context
 
 @param entityName a string value for the entity in core data
 @param fetchBatchSize limits the number of returned objects in each batch
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                            fetchBatchSize:(NSUInteger)fetchBatchSize;

/*
 Retrieves all entries for an entity in core data from default context
 
 @param entityClass a class value for the entity in core data
 @param fetchBatchSize limits the number of returned objects in each batch
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                             fetchBatchSize:(NSUInteger)fetchBatchSize;


/*
 Retrieves all entries for an entity in core data that match the provided predicate's conditions from default context
 
 @param entityName a string value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                                 predicate:(NSPredicate *)predicate;

/*
 Retrieves all entries for an entity in core data that match the provided predicate's conditions from default context
 
 @param entityClass a class value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate;


/*
 Retrieves all entries for an entity in core data that match the provided predicate's conditions from default context
 
 @param entityName a string value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 @param fetchBatchSize limits the number of returned objects in each batch
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                                 predicate:(NSPredicate *)predicate
                            fetchBatchSize:(NSUInteger)fetchBatchSize;

/*
 Retrieves all entries for an entity in core data that match the provided predicate's conditions from default context
 
 @param entityClass a class value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 @param fetchBatchSize limits the number of returned objects in each batch
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
                             fetchBatchSize:(NSUInteger)fetchBatchSize;


/*
 Retrieves ordered entries for an entity in core data from default context
 
 @param entityName a string value for the entity in core data
 @param orderBy the property/column name that will be used to order the entries
 @param ascending determines if the entries are ordered in ascending or descending
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                                   orderBy:(NSString *)orderBy
                            ascendingOrder:(BOOL)ascending;

/*
 Retrieves ordered entries for an entity in core data from default context
 
 @param entityClass a class value for the entity in core data
 @param orderBy the property/column name that will be used to order the entries
 @param ascending determines if the entries are ordered in ascending or descending
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                    orderBy:(NSString *)orderBy
                             ascendingOrder:(BOOL)ascending;

/*
 Retrieves ordered entries for an entity in core data from default context
 
 @param entityName a string value for the entity in core data
 @param orderBy the property/column name that will be used to order the entries
 @param ascending determines if the entries are ordered in ascending or descending
 @param fetchBatchSize limits the number of returned objects in each batch
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                                   orderBy:(NSString *)orderBy
                            ascendingOrder:(BOOL)ascending
                            fetchBatchSize:(NSUInteger)fetchBatchSize;

/*
 Retrieves ordered entries for an entity in core data from default context
 
 @param entityClass a class value for the entity in core data
 @param orderBy the property/column name that will be used to order the entries
 @param ascending determines if the entries are ordered in ascending or descending
 @param fetchBatchSize limits the number of returned objects in each batch
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                    orderBy:(NSString *)orderBy
                             ascendingOrder:(BOOL)ascending
                             fetchBatchSize:(NSUInteger)fetchBatchSize;


/*
 Retrieves ordered entries for an entity in core data that match the provided predicate's conditions from default context
 
 @param entityName a string value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 @param orderBy the property/column name that will be used to order the entries
 @param ascending determines if the entries are ordered in ascending or descending
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                                 predicate:(NSPredicate *)predicate
                                   orderBy:(NSString *)orderBy
                            ascendingOrder:(BOOL)ascending;

/*
 Retrieves ordered entries for an entity in core data that match the provided predicate's conditions from default context
 
 @param entityClass a class value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 @param orderBy the property/column name that will be used to order the entries
 @param ascending determines if the entries are ordered in ascending or descending
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
                                    orderBy:(NSString *)orderBy
                             ascendingOrder:(BOOL)ascending;

/*
 Retrieves ordered entries for an entity in core data that match the provided predicate's conditions from default context
 
 @param entityName a string value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 @param orderBy the property/column name that will be used to order the entries
 @param ascending determines if the entries are ordered in ascending or descending
 @param fetchBatchSize limits the number of returned objects in each batch
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                                 predicate:(NSPredicate *)predicate
                                   orderBy:(NSString *)orderBy
                            ascendingOrder:(BOOL)ascending
                            fetchBatchSize:(NSUInteger)fetchBatchSize;

/*
 Retrieves ordered entries for an entity in core data that match the provided predicate's conditions from default context
 
 @param entityClass a class value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 @param orderBy the property/column name that will be used to order the entries
 @param ascending determines if the entries are ordered in ascending or descending
 @param fetchBatchSize limits the number of returned objects in each batch
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
                                    orderBy:(NSString *)orderBy
                             ascendingOrder:(BOOL)ascending
                             fetchBatchSize:(NSUInteger)fetchBatchSize;

/*
 Retrieves all entries for an entity in core data from a specfic context
 
 @param entityName a string value for the entity in core data
 @param managedObjectContext the context used to access the entries
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                      managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/*
 Retrieves all entries for an entity in core data from a specfic context
 
 @param entityClass a class value for the entity in core data
 @param managedObjectContext the context used to access the entries
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                       managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/*
 Retrieves all entries for an entity in core data from a specfic context
 
 @param entityName a string value for the entity in core data
 @param fetchBatchSize limits the number of returned objects in each batch
 @param managedObjectContext the context used to access the entries
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                            fetchBatchSize:(NSUInteger)fetchBatchSize
                      managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/*
 Retrieves all entries for an entity in core data from a specfic context
 
 @param entityClass a class value for the entity in core data
 @param fetchBatchSize limits the number of returned objects in each batch
 @param managedObjectContext the context used to access the entries
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                             fetchBatchSize:(NSUInteger)fetchBatchSize
                       managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/*
 Retrieves ordered entries for an entity in core data that match the provided predicate's conditions from a specfic context
 
 @param entityName a string value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 @param orderBy the property/column name that will be used to order the entries
 @param ascending determines if the entries are ordered in ascending or descending
 @param managedObjectContext the context used to access the entries
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                                 predicate:(NSPredicate *)predicate
                                  orderBy:(NSString *)orderBy
                           ascendingOrder:(BOOL)ascending
                     managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/*
 Retrieves ordered entries for an entity in core data that match the provided predicate's conditions from a specfic context
 
 @param entityClass a class value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 @param orderBy the property/column name that will be used to order the entries
 @param ascending determines if the entries are ordered in ascending or descending
 @param managedObjectContext the context used to access the entries
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
                                    orderBy:(NSString *)orderBy
                             ascendingOrder:(BOOL)ascending
                       managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/*
 Retrieves ordered entries for an entity in core data that match the provided predicate's conditions from a specfic context
 
 @param entityName a string value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 @param orderBy the property/column name that will be used to order the entries
 @param ascending determines if the entries are ordered in ascending or descending
 @param fetchBatchSize limits the number of returned objects in each batch
 @param managedObjectContext the context used to access the entries
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                                 predicate:(NSPredicate *)predicate
                                   orderBy:(NSString *)orderBy
                            ascendingOrder:(BOOL)ascending
                            fetchBatchSize:(NSUInteger)fetchBatchSize
                      managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/*
 Retrieves ordered entries for an entity in core data that match the provided predicate's conditions from a specfic context
 
 @param entityClass a class value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 @param orderBy the property/column name that will be used to order the entries
 @param ascending determines if the entries are ordered in ascending or descending
 @param fetchBatchSize limits the number of returned objects in each batch
 @param managedObjectContext the context used to access the entries
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
                                    orderBy:(NSString *)orderBy
                             ascendingOrder:(BOOL)ascending
                             fetchBatchSize:(NSUInteger)fetchBatchSize
                       managedObjectContext:(NSManagedObjectContext *)managedObjectContext;


/*
 Retrieves ordered entries for an entity in core data that match the provided predicate's conditions from a specfic context
 
 @param entityName a string value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 @param orderBy the property/column name that will be used to order the entries
 @param ascending determines if the entries are ordered in ascending or descending
 @param fetchBatchSize limits the number of returned objects in each batch
 @param fetchLimit limits the number of returned objects (total)
 @param managedObjectContext the context used to access the entries
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                                 predicate:(NSPredicate *)predicate
                                   orderBy:(NSString *)orderBy
                            ascendingOrder:(BOOL)ascending
                            fetchBatchSize:(NSUInteger)fetchBatchSize
                                fetchLimit:(NSUInteger)fetchLimit
                      managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/*
 Retrieves ordered entries for an entity in core data that match the provided predicate's conditions from a specfic context
 
 @param entityClass a class value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 @param orderBy the property/column name that will be used to order the entries
 @param ascending determines if the entries are ordered in ascending or descending
 @param fetchBatchSize limits the number of returned objects in each batch
 @param fetchLimit limits the number of returned objects (total)
 @param managedObjectContext the context used to access the entries
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
                                    orderBy:(NSString *)orderBy
                             ascendingOrder:(BOOL)ascending
                             fetchBatchSize:(NSUInteger)fetchBatchSize
                                 fetchLimit:(NSUInteger)fetchLimit
                       managedObjectContext:(NSManagedObjectContext *)managedObjectContext;


/*
 Retrieves entries for an entity in core data that match the provided predicate's conditions from a specfic context
 
 @param entityName a string value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 @param managedObjectContext the context used to access the entries
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                                 predicate:(NSPredicate *)predicate
                      managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/*
 Retrieves entries for an entity in core data that match the provided predicate's conditions from a specfic context
 
 @param entityClass a class value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 @param managedObjectContext the context used to access the entries
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
                       managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/*
 Retrieves entries for an entity in core data that match the provided predicate's conditions from a specfic context
 
 @param entityName a string value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 @param managedObjectContext the context used to access the entries
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityName:(NSString *)entityName
                                 predicate:(NSPredicate *)predicate
                            fetchBatchSize:(NSUInteger)fetchBatchSize
                      managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/*
 Retrieves entries for an entity in core data that match the provided predicate's conditions from a specfic context
 
 @param entityClass a class value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 @param managedObjectContext the context used to access the entries
 
 @return an array of nsmanagedobjects
 */
+ (NSArray *) retrieveEntriesForEntityClass:(Class)entityClass
                                  predicate:(NSPredicate *)predicate
                             fetchBatchSize:(NSUInteger)fetchBatchSize
                       managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

#pragma mark - Single retrieval

/*
 Retrieves first entry for an entity in core data from default context
 
 @param entityName a string value for the entity in core data
 
 @return nsmanagedobject
 */
+ (id) retrieveFirstEntryForEntityName:(NSString *)entityName;

/*
 Retrieves first entry for an entity in core data from default context
 
 @param entityClass a class value for the entity in core data
 
 @return nsmanagedobject
 */
+ (id) retrieveFirstEntryForEntityClass:(Class)entityClass;

/*
 Retrieves first entry for an entity in core data from a specifc context
 
 @param entityName a string value for the entity in core data
 
 @return nsmanagedobject
 */
+ (id) retrieveFirstEntryForEntityName:(NSString *)entityName
                  managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/*
 Retrieves first entry for an entity in core data from a specifc context
 
 @param entityClass a class value for the entity in core data
 
 @return nsmanagedobject
 */
+ (id) retrieveFirstEntryForEntityClass:(Class)entityClass
                   managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/*
 Retrieves first entry for an entity in core data from default context
 
 @param entityName a string value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 @param orderBy the property/column name that will be used to order the entries
 @param ascending determines if the entries are ordered in ascending or descending
 
 @return nsmanagedobject
 */
+ (id) retrieveFirstEntryForEntityName:(NSString *)entityName
                             predicate:(NSPredicate *)predicate
                               orderBy:(NSString *)orderBy
                        ascendingOrder:(BOOL)ascending;

/*
 Retrieves first entry for an entity in core data from default context
 
 @param entityClass a class value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 @param orderBy the property/column name that will be used to order the entries
 @param ascending determines if the entries are ordered in ascending or descending
 
 @return nsmanagedobject
 */
+ (id) retrieveFirstEntryForEntityClass:(Class)entityClass
                              predicate:(NSPredicate *)predicate
                                orderBy:(NSString *)orderBy
                         ascendingOrder:(BOOL)ascending;

/*
 Retrieves first entry for an entity in core data from specfic context
 
 @param entityName a string value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 @param orderBy the property/column name that will be used to order the entries
 @param ascending determines if the entries are ordered in ascending or descending
 @param managedObjectContext the context used to access the entries
 
 @return nsmanagedobject
 */
+ (id) retrieveFirstEntryForEntityName:(NSString *)entityName
                             predicate:(NSPredicate *)predicate
                               orderBy:(NSString *)orderBy
                        ascendingOrder:(BOOL)ascending
                  managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/*
 Retrieves first entry for an entity in core data from specfic context
 
 @param entityClass a class value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 @param orderBy the property/column name that will be used to order the entries
 @param ascending determines if the entries are ordered in ascending or descending
 @param managedObjectContext the context used to access the entries
 
 @return nsmanagedobject
 */
+ (id) retrieveFirstEntryForEntityClass:(Class)entityClass
                              predicate:(NSPredicate *)predicate
                                orderBy:(NSString *)orderBy
                         ascendingOrder:(BOOL)ascending
                   managedObjectContext:(NSManagedObjectContext *)managedObjectContext;


/*
 Retrieves first entry for an entity in core data that match the provided predicate's conditions from default context
 
 @param entityName a string value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 
 @return nsmanagedobject
 */
+ (id) retrieveFirstEntryForEntityName:(NSString *)entityName
                             predicate:(NSPredicate *)predicate;

/*
 Retrieves first entry for an entity in core data that match the provided predicate's conditions from default context
 
 @param entityClass a class value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 
 @return nsmanagedobject
 */
+ (id) retrieveFirstEntryForEntityClass:(Class)entityClass
                              predicate:(NSPredicate *)predicate;

/*
 Retrieves first entry for an entity in core data that match the provided predicate's conditions from specfic context
 
 @param entityName a string value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 @param managedObjectContext the context used to access the entries
 
 @return nsmanagedobject
 */
+ (id) retrieveFirstEntryForEntityName:(NSString *)entityName
                             predicate:(NSPredicate *)predicate
                  managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/*
 Retrieves first entry for an entity in core data that match the provided predicate's conditions from specfic context
 
 @param entityClass a class value for the entity in core data
 @param predicate a predicate used to limit the entries returned
 @param orderBy the property/column name that will be used to order the entries
 @param ascending determines if the entries are ordered in ascending or descending
 @param managedObjectContext the context used to access the entries
 
 @return nsmanagedobject
 */
+ (id) retrieveFirstEntryForEntityClass:(Class)entityClass
                              predicate:(NSPredicate *)predicate
                   managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end

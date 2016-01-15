//
//  NSEntityDescription+CDSEntityDescription.h
//  CoreDataServices
//
//  Created by William Boles on 08/01/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

@import CoreData;

@interface NSEntityDescription (CDSEntityDescription)

/**
 Retrieves NSEntityDescription instance for core data entity class.
 
 @param entityClass - class value for the entity in core data.
 @param managedObjectContext - the context used to access the entries.
 
 @return NSEntityDescription instance.
 */
+ (NSEntityDescription *)cds_entityForClass:(Class)entityClass
                     inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

/**
 Inserts instance of entity class into core data.
 
 @param entityClass - class value for the entity in core data.
 @param managedObjectContext - the context used to access the entries.
 
 @return NSManagedObject instance of entityClass.
 */
+ (__kindof NSManagedObject *)cds_insertNewObjectForEntityForClass:(Class)entityClass
                                            inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end

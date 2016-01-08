//
//  NSEntityDescription+CDSEntityDescription.h
//  CoreDataServices
//
//  Created by William Boles on 08/01/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSEntityDescription (CDSEntityDescription)

/**
 Retrives NSEntityDescription instance for core data entity class.
 
 @param entityClass - class value for the entity in core data.
 @param managedObjectContext - the context used to access the entries.
 
 @return NSEntityDescription instance.
 */
+ (NSEntityDescription *)entityForClass:(Class)entityClass
                 inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end

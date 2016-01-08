//
//  NSFetchRequest+CDSFetchRequest.h
//  CoreDataServices
//
//  Created by William Boles on 08/01/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSFetchRequest (CDSFetchRequest)

/**
 Convenience init'er to allow for retreive of a NSFetchRequest instance given a core data entity class. 
 
 @param entityClass - class value for the entity in core data.
 
 @return NSEntityDescription instance.
 */
+ (instancetype)fetchRequestWithEntityClass:(Class)entityClass;

@end

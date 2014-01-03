//
//  CoreDataServices.h
//  CoreDataServices
//
//  Created by William Boles on 11/03/2013.
//  Copyright (c) 2013 Boles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDSServiceManager : NSObject

/*
 ManagedObjectContext that is used as the default managedObjectContext
 
 If when accessing a core data entity, if no managedobjectcontext is specified this one will be used
 
 @return Managed Object Context
 */
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

/*
 Singleton
 
 @return common CDSServiceManager instance
 */
+ (CDSServiceManager *) sharedInstance;

/*
 Class convenience method for accessing the managedObjectContext that executes on the main thread
 
 This is the managedObjectContext set as managedObjectContext property
 
 @return ManagedObjectContext
 */
+ (NSManagedObjectContext *) managedObjectContext;

/*
 Saves default managedObjectContext
 */
+ (void) saveManagedObjectContext;

/*
 Saves specfic managedObjectContext
 
 @param managedObjectContext to be saved
 */
+ (void) saveManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end

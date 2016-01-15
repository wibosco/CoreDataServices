//
//  CoreDataServices.h
//  CoreDataServices
//
//  Created by William Boles on 15/04/2014.
//  Copyright (c) 2014 Boles. All rights reserved.
//

@import CoreData;
@import Foundation;
@import UIKit;

@interface CDSServiceManager : NSObject

/*
 ManagedObjectContext that is used as the default managedObjectContext
 
 If when accessing a core data entity, if no managedobjectcontext is specified this one will be used
 
 @return Managed Object Context
 */
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

/*
 Returns the global CDSServiceManager instance.
 
 @return CDSServiceManager instance.
 */
+ (instancetype)sharedInstance;

/**
 Sets Up the core data stack using a model with the filename.
 
 @param name - filename of the model to load.
 */
- (void)setupModelURLWithModelName:(NSString *)name;

/*
 Saves the managedObjectContext.
 */
- (void)saveManagedObjectContext;

/**
 Destroys all data from core data, tears down the stack and builds it up again.
 */
- (void)reset;

/**
 Destroys all data from core data and tears down the stack.
 */
- (void)clear;

@end

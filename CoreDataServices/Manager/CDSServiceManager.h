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

/**
 A singleton manager that is responsible for setting up a typical (one context) core data stack and providing access to the main queue context. Also contains some convenience methods for interacting with that main queue context.
 */
@interface CDSServiceManager : NSObject

/*
 `NSManagedObjectContext` instance that is used as the default context.
 
 This context should be used on the main thread - using concurrancy type: `NSMainQueueConcurrencyType`.
 
 @return `NSManagedObjectContext` instance.
 */
@property (nonatomic, strong, readonly) NSManagedObjectContext *mainManagedObjectContext;

/*
 `NSManagedObjectContext` instance that is used as the background context
 
 This context should be used on a background thread - using concurrancy type: `NSPrivateQueueConcurrencyType`.
 
 return `NSManagedObjectContext` instance.
 */
@property (nonatomic, strong, readonly) NSManagedObjectContext *backgroundManagedObjectContext;

/*
 Returns the global CDSServiceManager instance.
 
 @return CDSServiceManager shared instance.
 */
+ (instancetype)sharedInstance;

/**
 Sets Up the core data stack using a model with the filename.
 
 @param name - filename of the model to load.
 */
- (void)setupModelURLWithModelName:(NSString *)name;

/*
 Saves the managed object context that is used via the `mainManagedObjectContext` property.
 */
- (void)saveMainManagedObjectContext;

/*
 Saves the managed object context that is set used the `NSPrivateQueueConcurrencyType` property.
 
 Saving the backgroundManagedObjectContext will cause the mainManagedObjectContext to be saved. This can result in a slightly longer save operation however the trade-off is to ensure "data correctness" over performance.
 */
- (void)saveBackgroundManagedObjectContext;

/**
 Destroys all data from core data and tears down the stack.
 */
- (void)clear;

@end

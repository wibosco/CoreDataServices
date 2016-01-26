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
 `NSManagedObjectContext` instance that is used as the default context.
 
 This context should be used on the main thread. Setup using concurrancy type: `NSMainQueueConcurrencyType`.
 
 @return `NSManagedObjectContext` instance.
 */
@property (nonatomic, strong, readonly) NSManagedObjectContext *mainManagedObjectContext;

/*
 `NSManagedObjectContext` instance that is used as the background context
 
 This context should be used on a background thread. Setup using concurrancy type: `NSPrivateQueueConcurrencyType`.
 
 return `NSManagedObjectContext` instance.
 */
@property (nonatomic, strong, readonly) NSManagedObjectContext *backgroundManagedObjectContext;

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
 Saves the mainManagedObjectContext.
 */
- (void)saveMainManagedObjectContext;

/*
 Saves the backgroundManagedObjectContext.
 
 Saving the backgroundManagedObjectContext will cause the mainManagedObjectContext to be saved. This can result in a slightly longer save operation however the trade-off is to ensure "data correctness" over performance.
 */
- (void)saveBackgroundManagedObjectContext;

/**
 Destroys all data from core data and tears down the stack.
 */
- (void)clear;

@end

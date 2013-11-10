//
//  CoreDataServices.m
//  CoreDataServices
//
//  Created by William Boles on 11/03/2013.
//  Copyright (c) 2013 Boles. All rights reserved.
//

#import "CDSServiceManager.h"

@implementation CDSServiceManager

static CDSServiceManager *SHARED_INSTANCE = nil;

#pragma mark - Singleton

+ (CDSServiceManager *) sharedInstance
{
    if (SHARED_INSTANCE == nil)
    {
		SHARED_INSTANCE = [[super allocWithZone:NULL] init];
	}
	
	return SHARED_INSTANCE;
}

#pragma mark - Managed Object Context

+ (void) saveManagedObjectContext
{
    [CDSServiceManager saveManagedObjectContext:[CDSServiceManager managedObjectContext]];
}

+ (void) saveManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSError *error = nil;
    
    if (![managedObjectContext save:&error])
    {
        NSLog(@"Couldn't save context: %@", [error userInfo]);
    }
}

+ (NSManagedObjectContext *) managedObjectContext
{
    return [CDSServiceManager sharedInstance].managedObjectContext;
}

@end

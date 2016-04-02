//
//  CDEUserInsertionOperation.m
//  iOSExample
//
//  Created by William Boles on 25/01/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import "CDEUserInsertionOperation.h"

#import <CoreDataServices/CoreDataServices-Swift.h>

#import "CDEUser.h"

@interface CDEUserInsertionOperation ()

@property (nonatomic, copy) void (^completion)(void);

- (NSUInteger)countOfTotalUsers;

@end

@implementation CDEUserInsertionOperation

#pragma mark - Init

- (instancetype)initWithCompletion:(void (^)(void))completion
{
    self = [super init];
    
    if (self)
    {
        self.completion = completion;
    }
    
    return self;
}

#pragma mark - Main

- (void)main
{
    [super main];
    
    /*----------------*/
    
    [[ServiceManager sharedInstance].backgroundManagedObjectContext performBlockAndWait:^
    {
        CDEUser *user = [NSEntityDescription cds_insertNewObjectForEntityForClass:[CDEUser class]
                                                           inManagedObjectContext:[CDSServiceManager sharedInstance].backgroundManagedObjectContext];
        
        user.userID = [NSUUID UUID].UUIDString;
        user.name = [NSString stringWithFormat:@"Operation %@", @([self countOfTotalUsers])];
        user.age = @(arc4random_uniform(102));
        
        [[CDSServiceManager sharedInstance] saveBackgroundManagedObjectContext];
        
        self.completion();
    }];
}

#pragma mark - Total

- (NSUInteger)countOfTotalUsers
{
    return [[CDSServiceManager sharedInstance].backgroundManagedObjectContext cds_retrieveEntriesCountForEntityClass:[CDEUser class]];
}

@end

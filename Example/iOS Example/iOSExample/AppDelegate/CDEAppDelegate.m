//
//  AppDelegate.m
//  iOSExample
//
//  Created by William Boles on 15/01/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import "CDEAppDelegate.h"

#import <CoreDataServices/CDSServiceManager.h>

#import "CDEFirstViewController.h"

@interface CDEAppDelegate ()

@property (nonatomic, strong) CDEFirstViewController *viewController;

@end

@implementation CDEAppDelegate

#pragma mark - AppLifeCycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[CDSServiceManager sharedInstance] setupModelURLWithModelName:@"Model"];
    
    /*-------------------*/
    
    self.window.backgroundColor = [UIColor clearColor];
    self.window.clipsToBounds = NO;
    
    [self.window makeKeyAndVisible];
    
    /*-------------------*/
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[CDSServiceManager sharedInstance] saveManagedObjectContext];
}

#pragma mark - Window

- (UIWindow *)window
{
    if (!_window)
    {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.rootViewController = self.navigationController;
    }
    
    return _window;
}

#pragma mark - Navigation

- (UINavigationController *)navigationController
{
    if (!_navigationController)
    {
        _navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    }
    
    return _navigationController;
}

#pragma mark - ViewController

- (CDEFirstViewController *)viewController
{
    if (!_viewController)
    {
        _viewController = [[CDEFirstViewController alloc] init];
    }
    
    return _viewController;
}

@end

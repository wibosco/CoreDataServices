//
//  AppDelegate.m
//  iOSExample
//
//  Created by William Boles on 15/01/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import "CDEAppDelegate.h"

#import <CoreDataServices/CoreDataServices-Swift.h>

#import "CDEUserMainContextViewController.h"
#import "CDEUserBackgroundContextViewController.h"

@interface CDEAppDelegate ()

@property (nonatomic, strong) CDEUserMainContextViewController *mainContextViewController;

@property (nonatomic, strong) CDEUserBackgroundContextViewController *backgroundContextViewController;

@property (nonatomic, strong) UINavigationController *mainContextNavigationController;

@property (nonatomic, strong) UINavigationController *backgroundContextNavigationController;

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
    [[CDSServiceManager sharedInstance] saveMainManagedObjectContext];
}

#pragma mark - Window

- (UIWindow *)window
{
    if (!_window)
    {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.rootViewController = self.tabBarController;
    }
    
    return _window;
}

#pragma mark - Navigation

- (UITabBarController *)tabBarController
{
    if (!_tabBarController)
    {
        _tabBarController = [[UITabBarController alloc] init];
        
        [_tabBarController addChildViewController:self.mainContextNavigationController];
        [_tabBarController addChildViewController:self.backgroundContextNavigationController];
    }
    
    return _tabBarController;
}

- (UINavigationController *)mainContextNavigationController
{
    if (!_mainContextNavigationController)
    {
        _mainContextNavigationController = [[UINavigationController alloc] initWithRootViewController:self.mainContextViewController];
        
        UITabBarItem *mainContextNavigationControllerItem = [[UITabBarItem alloc] initWithTitle:@"Main"
                                                                                          image:[UIImage imageNamed:@"first"]
                                                                                            tag:0];
        
        [_mainContextNavigationController setTabBarItem:mainContextNavigationControllerItem];
    }
    
    return _mainContextNavigationController;
}

- (UINavigationController *)backgroundContextNavigationController
{
    if (!_backgroundContextNavigationController)
    {
        _backgroundContextNavigationController = [[UINavigationController alloc] initWithRootViewController:self.backgroundContextViewController];
        
        UITabBarItem *backgroundContextNavigationControllerItem = [[UITabBarItem alloc] initWithTitle:@"Background"
                                                                                                image:[UIImage imageNamed:@"second"]
                                                                                                  tag:1];
        
        [_backgroundContextNavigationController setTabBarItem:backgroundContextNavigationControllerItem];
    }
    
    return _backgroundContextNavigationController;
}

#pragma mark - ViewController

- (CDEUserMainContextViewController *)mainContextViewController
{
    if (!_mainContextViewController)
    {
        _mainContextViewController = [[CDEUserMainContextViewController alloc] init];
    }
    
    return _mainContextViewController;
}

- (CDEUserBackgroundContextViewController *)backgroundContextViewController
{
    if (!_backgroundContextViewController)
    {
        _backgroundContextViewController = [[CDEUserBackgroundContextViewController alloc] init];
    }
    
    return _backgroundContextViewController;
}

@end

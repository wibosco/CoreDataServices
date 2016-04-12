[![Build Status](https://travis-ci.org/wibosco/CoreDataServices.svg)](https://travis-ci.org/wibosco/CoreDataServices)
[![Version](https://img.shields.io/cocoapods/v/CoreDataServices.svg?style=flat)](http://cocoapods.org/pods/CoreDataServices)
[![License](https://img.shields.io/cocoapods/l/CoreDataServices.svg?style=flat)](http://cocoapods.org/pods/CoreDataServices)
[![Platform](https://img.shields.io/cocoapods/p/CoreDataServices.svg?style=flat)](http://cocoapods.org/pods/CoreDataServices)
[![CocoaPods](https://img.shields.io/cocoapods/metrics/doc-percent/CoreDataServices.svg)](http://cocoapods.org/pods/CoreDataServices)

CoreDataServices is a suite of helper classes and categories to help to remove some of the boilerplate that surrounds using Core Data.

##Installation via [CocoaPods](https://cocoapods.org/)

To integrate CoreDataServices into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

pod 'CoreDataServices'
```

Then, run the following command:

```bash
$ pod install
```

> CocoaPods 0.39.0+ is required to build CoreDataServices.

##Usage

CoreDataServices is mainly composed of a suite of categories that extend `NSManagedObjectContext`.

####Init

######Swift

```swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

	ServiceManager.sharedInstance.setupModel("Model")//model is the name of the `xcdatamodeld` file

    /*----------------*/
    
    self.window!.rootViewController = self.rootViewController
    self.window!.makeKeyAndVisible()
    
    /*----------------*/
    
    return true
}
```

######Objective-C

```objc
#import <CoreDataServices/CDSServiceManager.h>

....

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[CDSServiceManager sharedInstance] setupModelURLWithModelName:@"Model"];//model is the name of the `xcdatamodeld` file
    
    /*-------------------*/
    
    self.window.backgroundColor = [UIColor clearColor];
    self.window.clipsToBounds = NO;
    
    [self.window makeKeyAndVisible];
    
    /*-------------------*/
    
    return YES;
}
```

####Retrieving

######Swift

```swift
lazy var users: Array<User> = {
	let ageSort = NSSortDescriptor(key: "age", ascending: true)

	let users = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveEntries(User.self, sortDescriptors: [ageSort])

	return users
}
```

######Objective-C

```objc
#import <CoreDataServices/NSManagedObjectContext+CDSRetrieval.h>

....

- (NSArray *)users
{
    if (!_users)
    {
        NSSortDescriptor *ageSort = [NSSortDescriptor sortDescriptorWithKey:@"age"
                                                                  ascending:YES];
        
        _users = [[CDSServiceManager sharedInstance].mainManagedObjectContext cds_retrieveEntriesForEntityClass:[CDEUser class]
                                                                                            	sortDescriptors:@[ageSort]];
    }
    
    return _users;
}
```

####Counting

######Swift

```swift
func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
	let totalUsers = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveEntriesCount(User.self)

	return "Total Users: \(totalUsers)"
}
```

######Objective-C

```objc
#import <CoreDataServices/NSManagedObjectContext+CDSCount.h>

....

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Total Users: %@", @([[CDSServiceManager sharedInstance].managedObjectContext cds_retrieveEntriesCountForEntityClass:[CDEUser class]])];
}
```

####Deleting

######Swift

```swift
func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
	let user = self.users[indexPath.row]

	let predicate = NSPredicate(format: "userID MATCHES '\(user.userID)'")

	ServiceManager.sharedInstance.mainManagedObjectContext.deleteEntries(User.self, predicate: predicate)

	self.users = nil

	self.tableView.reloadData()
}
```

######Objective-C

```objc
#import <CoreDataServices/NSManagedObjectContext+CDSDelete.h>

....

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CDEUser *user = self.users[indexPath.row];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID MATCHES %@", user.userID];
    
    [[CDSServiceManager sharedInstance].managedObjectContext cds_deleteEntriesForEntityClass:[CDEUser class]
                                                                                   predicate:predicate];
    
    self.users = nil;
    
    [self.tableView reloadData];
}
```

####Saving

######Swift

```swift
    //Main thread's context
    ServiceManager.sharedInstance.saveMainManagedObjectContext()
    
    //Background thread's context
    ServiceManager.sharedInstance.saveBackgroundManagedObjectContext()
}
```

######Objective-C

```objc
#import <CoreDataServices/CDSServiceManager.h>

....

    //Main thread's context
    [[CDSServiceManager sharedInstance] saveMainManagedObjectContext];
    
    //Background thread's context
    [[CDSServiceManager sharedInstance] saveBackgroundManagedObjectContext];
}
```

What is interesting to note is when calling `saveBackgroundManagedObjectContext`, CoreDataServices will also call `saveMainManagedObjectContext`, this introduces a small performance overhead but ensures that save events are not lost if the app crashes.

####Using in multi-threaded project

CoreDataServices has the following implementation of Core Data stack:

* One  `NSManagedObjectContext` using the `NSMainQueueConcurrencyType` concurrency type that is attached directly to the `PersistentStoreCoordinator` - the intention is for this context to only be used on the main-thread.
* One  `NSManagedObjectContext` using the `NSPrivateQueueConcurrencyType` concurrency type that has the `NSMainQueueConcurrencyType` context as it's parent - the intention is for this context to only be used on background-threads. 

The newer main/private concurrency solution rather than confinement concurrency as it offers conceptually the easiest solution. However in order for this to behave as expected when on a background-thread you will need to ensure that you use either `performBlock` or `performBlockAndWait` to access the background-thread context. to ensure that the context is being used on the correct thread. 

An interesting article about different configurations to the Core Data stack can be found [here](http://floriankugler.com/2013/04/29/concurrent-core-data-stack-performance-shootout/).

```objc
#import <CoreDataServices/CDSServiceManager.h>

....

	//this will block the current thread until the work is completed
    [[CDSServiceManager sharedInstance].backgroundManagedObjectContext performBlockAndWait:^
    {
    	//work here
    }];
    
    	//this will not block the current thread until the work is completed
    [[CDSServiceManager sharedInstance].backgroundManagedObjectContext performBlock:^
    {
    	//work here
    }];
```

> CoreDataServices comes with an [example project](https://github.com/wibosco/CoreDataServices/tree/master/Example/iOS%20Example) to provide more details than listed above.

> CoreDataServices uses [modules](http://useyourloaf.com/blog/modules-and-precompiled-headers.html) for importing/using frameworks - you will need to enable this in your project.

##Found an issue?

Please open a [new Issue here](https://github.com/wibosco/CoreDataServices/issues/new) if you run into a problem specific to CoreDataServices, have a feature request, or want to share a comment. Note that general Core Data questions should be asked on [Stack Overflow](http://stackoverflow.com).

Pull requests are encouraged and greatly appreciated! Please try to maintain consistency with the existing [code style](http://www.williamboles.me/objective-c-coding-style). If you're considering taking on significant changes or additions to the project, please communicate in advance by opening a new Issue. This allows everyone to get onboard with upcoming changes, ensures that changes align with the project's design philosophy, and avoids duplicated work.

[![Build Status](https://travis-ci.org/wibosco/CoreDataServices.svg)](https://travis-ci.org/wibosco/CoreDataServices)
[![Version](https://img.shields.io/cocoapods/v/CoreDataServices.svg?style=flat)](http://cocoapods.org/pods/CoreDataServices)
[![License](https://img.shields.io/cocoapods/l/CoreDataServices.svg?style=flat)](http://cocoapods.org/pods/CoreDataServices)
[![Platform](https://img.shields.io/cocoapods/p/CoreDataServices.svg?style=flat)](http://cocoapods.org/pods/CoreDataServices)
[![CocoaPods](https://img.shields.io/cocoapods/metrics/doc-percent/CoreDataServices.svg)](http://cocoapods.org/pods/CoreDataServices)
<a href="https://twitter.com/wibosco"><img src="https://img.shields.io/badge/twitter-@wibosco-blue.svg?style=flat" alt="Twitter: @wibosco" /></a>

CoreDataServices is a suite of helper classes and categories to help to remove some of the boilerplate that surrounds using Core Data.

## Installation via [CocoaPods](https://cocoapods.org/)

To integrate CoreDataServices into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'

pod 'CoreDataServices'
```

Then, run the following command:

```bash
$ pod install
```

> CocoaPods 1.0.1+ is required to build CoreDataServices.

## Usage

CoreDataServices is mainly composed of a suite of categories/extensions that extend `NSManagedObjectContext`.

#### Init

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    ServiceManager.shared.setupModel(name: "Model")
    return true
}
```

#### Retrieving

```swift
var _users: [User]?
var users: [User] {
    if(_users == nil) {
        let sortDescriptor = NSSortDescriptor(key: "dateAdded", ascending: false)

        _users = ServiceManager.shared.mainManagedObjectContext.retrieveEntries(entityClass: User.self, sortDescriptors: [sortDescriptor])
    }

    return _users!
}
```

#### Counting

```swift
func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let totalUsers = ServiceManager.shared.mainManagedObjectContext.retrieveEntriesCount(entityClass: User.self)
    return "Total Users: \(totalUsers)"
}
```

#### Deleting

```swift
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    let user = users[indexPath.row]

    let predicate = NSPredicate(format: "userID==%@", user.userID!)
    ServiceManager.shared.mainManagedObjectContext.deleteEntries(entityClass: User.self, predicate: predicate)
    ServiceManager.shared.saveMainManagedObjectContext()

    clearAndReloadUsers()
}
```

#### Saving

```swift
ServiceManager.shared.mainManagedObjectContext.saveAndForcePushChangesIfNeeded()
```

What is interesting to note is when calling `saveAndForcePushChangesIfNeeded` on a background/private context the changes will be propagated through parent contexts until `save` is called on the main context. This introduces a small performance overhead but ensures that saved changes are not lost if the app crashes.

Below are two convenience methods to make saving easier.

```swift
//Main thread's context
ServiceManager.shared.saveMainManagedObjectContext()

//Background thread's context
ServiceManager.shared.saveBackgroundManagedObjectContext()
```

#### Using BackgroundManagedObjectContext

```swift
func addUserOnBackgroundContext() {
    DispatchQueue.global(qos: .background).async { [weak self] in
        ServiceManager.shared.backgroundManagedObjectContext.performAndWait({
            let user = NSEntityDescription.insertNewObject(entityClass: User.self, managedObjectContext: ServiceManager.shared.backgroundManagedObjectContext)

            user.userID = UUID().uuidString
            user.name = "Anna BackgroundContext"
            user.dateOfBirth = Date.randomDate(daysBack: 30000)

            ServiceManager.shared.saveBackgroundManagedObjectContext()

            DispatchQueue.main.async(execute: {
                self?.clearAndReloadUsers()
            })
        })
    }
}
```

#### Using in multi-threaded project

CoreDataServices has the following implementation of Core Data stack:

* One  `NSManagedObjectContext` using the `.mainQueueConcurrencyType` concurrency type that is attached directly to the `PersistentStoreCoordinator` - the intention is for this context to only be used on the main-thread.
* One  `NSManagedObjectContext` using the `.privateQueueConcurrencyType` concurrency type that has the `.mainQueueConcurrencyType` context as it's parent - the intention is for this context to only be used on background-threads.

CoreDataServices uses the newer main/private concurrency solution rather than confinement concurrency as it offers conceptually the easiest solution. However in order for this to behave as expected when on a background-thread you will need to ensure that you use either `perform` or `performAndWait` to access the background-thread context. to ensure that the context is being used on the correct thread.

An interesting article about different configurations to the Core Data stack can be found [here](http://floriankugler.com/2013/04/29/concurrent-core-data-stack-performance-shootout/).

> CoreDataServices comes with an [example project](https://github.com/wibosco/CoreDataServices/tree/master/Examples/Swift%20Example) to provide more details than listed above.

> CoreDataServices uses [modules](http://useyourloaf.com/blog/modules-and-precompiled-headers.html) for importing/using frameworks - you will need to enable this in your project.

## Found an issue?

Please open a [new Issue here](https://github.com/wibosco/CoreDataServices/issues/new) if you run into a problem specific to CoreDataServices, have a feature request, or want to share a comment. Note that general Core Data questions should be asked on [Stack Overflow](http://stackoverflow.com).

Pull requests are encouraged and greatly appreciated! Please try to maintain consistency with the existing code style. If you're considering taking on significant changes or additions to the project, please communicate in advance by opening a new Issue. This allows everyone to get onboard with upcoming changes, ensures that changes align with the project's design philosophy, and avoids duplicated work.

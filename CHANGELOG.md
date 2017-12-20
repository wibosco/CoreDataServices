#Change Log
All notable changes to this project will be documented in this file.
`CoreDataServices` adheres to [Semantic Versioning](http://semver.org/).

---

## [4.0.0](https://github.com/wibosco/CoreDataServices/releases/tag/4.0.0)

* Updated project to use Swift 4.0
* Removed pod dependency on `SwiftLint` and `ConvenientFileManager`
* Renamed `sharedInstance` to `shared`
* Implemented `reset` - clears the Core Data stack and rebuilds it

## [3.2.2](https://github.com/wibosco/CoreDataServices/releases/tag/3.2.2)

* Added `SwiftLint`

## [3.2.1](https://github.com/wibosco/CoreDataServices/releases/tag/3.2.1)

* Increased code coverage of unit tests

## [3.2.0](https://github.com/wibosco/CoreDataServices/releases/tag/3.2.0)

* Added generic `save` extension on `NSManagedObjectContext` so force changes from child->parent context

## [3.1.0](https://github.com/wibosco/CoreDataServices/releases/tag/3.1.0)

* Added generic support to entityDescription class to avoid having to cast as much

## [3.0.0](https://github.com/wibosco/CoreDataServices/releases/tag/3.0.0)

* Updated project to use Swift 3.0
* Added generic support to retrieval class to avoid having to cast as much

## [2.1.0](https://github.com/wibosco/CoreDataServices/releases/tag/2.1.0)

* Updated project to use Swift 2.3

## [2.0.6](https://github.com/wibosco/CoreDataServices/releases/tag/2.0.6)

* Removed unneeded `Parameters` from documentation
* Updated `README` to include examples of using this pod in a Swift project

## [2.0.5](https://github.com/wibosco/CoreDataServices/releases/tag/2.0.5)

* Updated documentation format to what is now expected

## [2.0.4](https://github.com/wibosco/CoreDataServices/releases/tag/2.0.4)

* Added `@objc` attribute to ServiceManager class name

## [2.0.3](https://github.com/wibosco/CoreDataServices/releases/tag/2.0.3)

* Updated example project to use new Swift version

## [2.0.2](https://github.com/wibosco/CoreDataServices/releases/tag/2.0.2)

* Added `public` to ServiceManager class and it's functions

## [2.0.1](https://github.com/wibosco/CoreDataServices/releases/tag/2.0.1)

* Added @objc attribute to ServiceManager class

## [2.0.0](https://github.com/wibosco/CoreDataServices/releases/tag/2.0.0)

* Converted project over to using Swift

* Implemented for passing the bundle when setting up the model

## [1.1.6](https://github.com/wibosco/CoreDataServices/releases/tag/1.1.6)

* Implemented for passing the bundle when setting up the model

## [1.1.5](https://github.com/wibosco/CoreDataServices/releases/tag/1.1.5)

* Don't assume `mainBundle` when loading the model

## [1.1.4](https://github.com/wibosco/CoreDataServices/releases/tag/1.1.4)

* Strip namespace out of `EntityClass` parameters

## [1.1.3](https://github.com/wibosco/CoreDataServices/releases/tag/1.1.3)

* Added better examples in readme, now it covers:
	* Init
	* Saving

## [1.1.2](https://github.com/wibosco/CoreDataServices/releases/tag/1.1.2)

* Improved `README`

## [1.1.1](https://github.com/wibosco/CoreDataServices/releases/tag/1.1.1)

* Conforming to Appledoc standard with documentation now
* Improved `README` with better explanation when working in a multi-threaded project

## [1.1.0](https://github.com/wibosco/CoreDataServices/releases/tag/1.1.0)

* Introduced a private `NSManagedObjectContext` property on `CDSServiceManager`
* Removed `reset` method as it was doing the same as `clear`
* Updated documentation to describe the architectural chooses and why they had been made
* Renamed the main `NSManagedObjectContext` property on `CDSServiceManager` from `managedObjectContext` to `mainManagedObjectContext` - sorry but I didn't want to provide both as I think it would just confuse the matter

## [1.0.1](https://github.com/wibosco/CoreDataServices/releases/tag/1.0.1)

* Introduced the CHANGELOG file

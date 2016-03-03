#Change Log
All notable changes to this project will be documented in this file.
`CoreDataServices` adheres to [Semantic Versioning](http://semver.org/).

---
## [1.1.5](https://github.com/wibosco/CoreDataServices/releases/tag/1.1.5)

* Don't assume `mainBundle` when loading the model

## [1.1.4](https://github.com/wibosco/CoreDataServices/releases/tag/1.1.4)

* Strip namespace out of `EntityClass` parameters

## [1.1.3](https://github.com/wibosco/CoreDataServices/releases/tag/1.1.3)

* Added better examples in readme, now it covers:
	* Init
	* Saving

## [1.1.2](https://github.com/wibosco/CoreDataServices/releases/tag/1.1.2)

* Improved readme

## [1.1.1](https://github.com/wibosco/CoreDataServices/releases/tag/1.1.1)

* Conforming to Appledoc standard with documentation now
* Improved readme with better explanation when working in a multi-threaded project

## [1.1.0](https://github.com/wibosco/CoreDataServices/releases/tag/1.1.0)

* Introduced a private `NSManagedObjectContext` property on `CDSServiceManager`
* Removed `reset` method as it was doing the same as `clear`
* Updated documentation to describe the architectural chooses and why they had been made
* Renamed the main `NSManagedObjectContext` property on `CDSServiceManager` from `managedObjectContext` to `mainManagedObjectContext` - sorry but I didn't want to provide both as I think it would just confuse the matter

## [1.0.1](https://github.com/wibosco/CoreDataServices/releases/tag/1.0.1)

* Introduced the CHANGELOG file

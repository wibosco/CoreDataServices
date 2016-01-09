CoreDataServices is a suite of helper classes to help to remove some of the boilerplate that surrounds using Core Data.

##Installation

CoreDataServices is intended to be installed via [Cocoapods](https://cocoapods.org/) 

CocoaPods is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries in your projects. See the [Getting Started Guide](https://guides.cocoapods.org/using/getting-started.html). You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 0.39.0+ is required to build CoreDataServices.

#### Podfile

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

##Curious?

Please open a [new Issue here](https://github.com/wibosco/CoreDataServices/issues/new) if you run into a problem specific to PureLayout, have a feature request, or want to share a comment. Note that general Core Data questions should be asked on [Stack Overflow](http://stackoverflow.com).

Pull requests are encouraged and greatly appreciated! Please try to maintain consistency with the existing [code style](http://www.williamboles.me/objective-c-coding-style). If you're considering taking on significant changes or additions to the project, please communicate in advance by opening a new Issue. This allows everyone to get onboard with upcoming changes, ensures that changes align with the project's design philosophy, and avoids duplicated work.

##Versions

To tag a version use:

```bash
git tag -a 1.1.5 -m 'Version 1.1.5'
```

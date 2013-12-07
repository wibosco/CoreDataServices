CoreDataServices
===========================

## How do I get CoreDataServices as a universal static library?

In the project you should see two targets:

1. CoreDataServices
2. CoreDataServicesLibrary

To produce a universal static library you need to ensure that you build the "CoreDataServicesLibrary" target, this is because it combines the i386 and ARM output into one static library that will run on both simulator and device.

So to get the universal static library you need to:

1. Build "CoreDataServicesLirary" target
2. Expand "Products" folder (in the project navigator)
3. Open context menu on "libCoreDataServices.a" and select "Show in folder" option
4. In the Finder window that opens naivgate to "Release-iphoneuniversal" folder (up one level)
5. Copy and drag both "libCoreDataServices.a" and the "Headers" folder into your project
6. Dance with joy!
//
//  ServiceManager.swift
//  CoreDataServices
//
//  Created by William Boles on 31/03/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import CoreData
import Foundation
import ConvenientFileManager

/**
 A singleton manager that is responsible for setting up a core data stack and providing access to both a main `NSManagedObjectContext` and private `NSManagedObjectContext` context. The implementation of this stack is where mainManagedObjectContext will be the parent of backgroundManagedObjectContext using the newer main/private concurrency solution rather than confinement. When performing Core Data tasks you should use `performBlock` or `performBlockAndWait` to ensure that the context is being used on the correct thread. This can lead to performance overhead when compared to alternative stack solutions (http://floriankugler.com/2013/04/29/concurrent-core-data-stack-performance-shootout/) however it is the simplest conceptually to understand.
 */
@objc(CDSServiceManager)
public class ServiceManager: NSObject {
    
    //MARK: Accessors

    /// URL of the directory where persistent store's is located.
    private lazy var storeDirectoryURL: NSURL = {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last!
        
        let storeDirectoryURL = documentsURL.URLByAppendingPathComponent("persistent-store")
        
        return storeDirectoryURL
    }()
    
    
    /// URL of where persistent store's is located.
    private lazy var storeURL: NSURL = {
        let modelFileName = self.modelURL?.URLByDeletingPathExtension?.lastPathComponent!
        let storeFilePath = "\(modelFileName!).sqlite"
        
        let storeURL = self.storeDirectoryURL.URLByAppendingPathComponent(storeFilePath)
        
        return storeURL
    }()
    
    private var modelURL: NSURL?
    
    /// Model of the persistent store.
    private var managedObjectModel: NSManagedObjectModel {
        get {
            if _managedObjectModel == nil {
                _managedObjectModel = NSManagedObjectModel(contentsOfURL: self.modelURL!)
            }
            
            return _managedObjectModel!
        }
    }
    
    private var _managedObjectModel: NSManagedObjectModel?
    
    /// Persistent store coordinator - responsible for handling communication with the persistent store
    private var persistentStoreCoordinator: NSPersistentStoreCoordinator {
        get {
            if _persistentStoreCoordinator == nil {
                _persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
                
                self.createPersistentStoreAndAssignToCoordinatorWithDeleteAndRetryOnError(_persistentStoreCoordinator!, deleteAndRetry: true)
            }
            
            return _persistentStoreCoordinator!
        }
    }
    
    private var _persistentStoreCoordinator: NSPersistentStoreCoordinator?
    
    /**
     `NSManagedObjectContext` instance that is used as the default context.
     
     This context should be used on the main thread - using concurrancy type: `NSMainQueueConcurrencyType`.
     */
    @objc(mainManagedObjectContext)
    public var mainManagedObjectContext: NSManagedObjectContext {
        get {
            objc_sync_enter(self)
            defer { objc_sync_exit(self) }
            
            if _mainManagedObjectContext == nil {
                _mainManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
                
                _mainManagedObjectContext!.persistentStoreCoordinator = self.persistentStoreCoordinator
            }
            
            return _mainManagedObjectContext!
        }
    }
    
    private var _mainManagedObjectContext: NSManagedObjectContext?
    
    /**
     `NSManagedObjectContext` instance that is used as the background context
     
     This context should be used on a background thread - using concurrancy type: `NSPrivateQueueConcurrencyType`.
     */
    @objc(backgroundManagedObjectContext)
    public var backgroundManagedObjectContext: NSManagedObjectContext {
        get {
            objc_sync_enter(self)
            defer { objc_sync_exit(self) }
            
            if _backgroundManagedObjectContext == nil {
                _backgroundManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
                
                _backgroundManagedObjectContext!.parentContext = self.mainManagedObjectContext
                _backgroundManagedObjectContext!.undoManager = nil
            }
            
            return _backgroundManagedObjectContext!
        }
    }
    
    private var _backgroundManagedObjectContext: NSManagedObjectContext?
    
    //MARK: - SharedInstance
    
    /**
     Returns the global ServiceManager instance.
     
     - Returns: ServiceManager shared instance.
     */
    @objc(sharedInstance)
    public static let sharedInstance = ServiceManager()
    
    //MARK: SetUp
    
    /**
     Sets Up the core data stack using a model with the filename.
     
     - Parameter name: filename of the model to load.
     */
    @objc(setupModelURLWithModelName:)
    public func setupModel(name: String) {
        self.setupModel(name, bundle: NSBundle.mainBundle())
    }
    
    /**
     Sets Up the core data stack using a model with the filename.
     
     - Parameter name: filename of the model to load.
     - Parameter bundle: bundle the model is in.
     */
    @objc(setupModelURLWithModelName:bundle:)
    public func setupModel(name: String, bundle: NSBundle) {
        self.modelURL = bundle.URLForResource(name, withExtension: "momd")
    }
    
    //MARK: PersistentStore
    
    /**
     Will attempt to create the persistent store and assign that persistent store to the coordinator.
     
     - Parameter deleteAndRetry: will delete the current persistent store and try creating it fresh. This can happen where lightweight migration has failed.
     */
    private func createPersistentStoreAndAssignToCoordinatorWithDeleteAndRetryOnError(coordinator: NSPersistentStoreCoordinator, deleteAndRetry: Bool) {
        var directoryCreated = true
        
        //Creating an additional directory so that when we clear we get all the files connected to Core Data
        if !NSFileManager.fileExistsAtPath(self.storeDirectoryURL.path!) {
            directoryCreated = NSFileManager.createDirectoryAtPath(self.storeDirectoryURL.path!)
        }
        
        if directoryCreated {
            var options = Dictionary<String, Bool>()
            options[NSMigratePersistentStoresAutomaticallyOption] = true
            options[NSInferMappingModelAutomaticallyOption] = true
            
            do {
                try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: self.storeURL, options: options)
            } catch let error as NSError {
                if  deleteAndRetry {
                    print("Unresolved persistent store error: \(error.description)")
                    print("Deleting and retrying")
                    
                    self.deletePersistentStore()
                    self.createPersistentStoreAndAssignToCoordinatorWithDeleteAndRetryOnError(coordinator, deleteAndRetry: false)
                } else {
                    print("Serious error with persistent store: \(error.description)")
                }
            }
        } else {
            print("Unable to persistentstore due to directory issue")
        }
    }
    
    /**
     Deletes the persistent store from the file system.
     */
    private func deletePersistentStore() {
        //Need to delete the directory so that we also get the `-shm` and `-wal` files
        NSFileManager.deleteDataAtPath(self.storeDirectoryURL.path!)
    }
    
    //MARK: Clear
    
    /**
     Destroys all data from core data and tears down the stack.
     */
    @objc(clear)
    public func clear() {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        _mainManagedObjectContext = nil
        _backgroundManagedObjectContext = nil
        
        _persistentStoreCoordinator = nil
        _managedObjectModel = nil
        
        self.deletePersistentStore()
    }
    
    //MARK: Save
    
    /**
     Saves the managed object context that is used via the `mainManagedObjectContext` var.
     */
    @objc(saveMainManagedObjectContext)
    public func saveMainManagedObjectContext() {
        self.mainManagedObjectContext.performBlockAndWait({
            if self.mainManagedObjectContext.hasChanges {
                do {
                    try self.mainManagedObjectContext.save()
                    
                    //Force context to process pending changes as cascading deletes may not be immediately applied by coredata.
                    self.mainManagedObjectContext.processPendingChanges()
                    
                } catch let error as NSError {
                    print("Couldn't save the main context: \(error.description)")
                }
            }
        })
    }
    
    /**
     Saves the managed object context that is set used the `NSPrivateQueueConcurrencyType` type.
     
     Saving the backgroundManagedObjectContext will cause the mainManagedObjectContext to be saved. This can result in a slightly longer save operation however the trade-off is to ensure "data correctness" over performance.
     */
    @objc(saveBackgroundManagedObjectContext)
    public func saveBackgroundManagedObjectContext() {
        self.backgroundManagedObjectContext.performBlockAndWait({
            if self.backgroundManagedObjectContext.hasChanges {
                do {
                    try self.backgroundManagedObjectContext.save()
                    
                    //Force context to process pending changes as cascading deletes may not be immediately applied by coredata.
                    self.backgroundManagedObjectContext.processPendingChanges()
                    
                    self.saveMainManagedObjectContext()
                    
                } catch let error as NSError {
                    print("Couldn't save the background context: \(error.description)")
                }
            }
        })
    }
}

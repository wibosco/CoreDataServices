//
//  ServiceManager.swift
//  CoreDataServices
//
//  Created by William Boles on 31/03/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import CoreData
import Foundation

/**
 A singleton manager that is responsible for setting up a core data stack and providing access to both a main `NSManagedObjectContext` and private `NSManagedObjectContext` context. The implementation of this stack is where mainManagedObjectContext will be the parent of backgroundManagedObjectContext using the newer main/private concurrency solution rather than confinement. When performing Core Data tasks you should use `performBlock` or `performBlockAndWait` to ensure that the context is being used on the correct thread. Please note, that this can lead to performance overhead when compared to alternative stack solutions (http://floriankugler.com/2013/04/29/concurrent-core-data-stack-performance-shootout/) however it is the simplest conceptually to understand.
 */
public class ServiceManager: NSObject {
    
    // MARK: - Accessors

    /// URL of the directory where persistent store's is located.
    private lazy var storeDirectoryURL: URL = {
        let storeDirectoryURL = FileManager.default.documentsDirectoryURL().appendingPathComponent("persistent-store")
        
        return storeDirectoryURL
    }()
    
    private var modelFileName: String?
    
    private var bundle: Bundle?
    
    /// URL of where persistent store's is located.
    private lazy var storeURL: URL = {
        guard let modelFileName = self.modelFileName else {
            fatalError("Ensure that setupModel is called before attempting to use your stack")
        }
        
        let storeFilePath = "\(modelFileName).sqlite"
        let storeURL = self.storeDirectoryURL.appendingPathComponent(storeFilePath)
        
        return storeURL
    }()
    
    private var modelURL: URL? {
        didSet {
            _ = persistentStoreCoordinator
        }
    }
    
    /// Model of the persistent store.
    private var managedObjectModel: NSManagedObjectModel {
        if _managedObjectModel == nil {
            _managedObjectModel = NSManagedObjectModel(contentsOf: modelURL!)
        }
        
        return _managedObjectModel!
    }
    
    private var _managedObjectModel: NSManagedObjectModel?
    
    /// Persistent store coordinator - responsible for handling communication with the persistent store
    private var persistentStoreCoordinator: NSPersistentStoreCoordinator {
        if _persistentStoreCoordinator == nil {
            _persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
            
            createPersistentStoreAndAssignToCoordinatorWithDeleteAndRetryOnError(coordinator: _persistentStoreCoordinator!, deleteAndRetry: true)
        }
        
        return _persistentStoreCoordinator!
    }
    
    private var _persistentStoreCoordinator: NSPersistentStoreCoordinator?
    
    /**
     `NSManagedObjectContext` instance that is used as the default context.
     
     This context should be used on the main thread - using concurrancy type: `NSMainQueueConcurrencyType`.
     */
    public var mainManagedObjectContext: NSManagedObjectContext {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if _mainManagedObjectContext == nil {
            _mainManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            
            _mainManagedObjectContext!.persistentStoreCoordinator = persistentStoreCoordinator
        }
        
        return _mainManagedObjectContext!
    }
    
    private var _mainManagedObjectContext: NSManagedObjectContext?
    
    /**
     `NSManagedObjectContext` instance that is used as the background context
     
     This context should be used on a background thread - using concurrancy type: `NSPrivateQueueConcurrencyType`.
     */
    public var backgroundManagedObjectContext: NSManagedObjectContext {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if _backgroundManagedObjectContext == nil {
            _backgroundManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            
            _backgroundManagedObjectContext!.parent = mainManagedObjectContext
            _backgroundManagedObjectContext!.undoManager = nil
        }
        
        return _backgroundManagedObjectContext!
    }
    
    private var _backgroundManagedObjectContext: NSManagedObjectContext?
    
    // MARK: - SharedInstance
    
    /**
     Returns the global ServiceManager instance.
     
     - Returns: ServiceManager shared instance.
     */
    public static let shared = ServiceManager()
    
    // MARK: - SetUp
    
    /**
     Sets Up the core data stack using a model with the filename.
     
     - Parameter name: filename of the model to load.
     */
    public func setupModel(name: String) {
        setupModel(name: name, bundle: Bundle.main)
    }
    
    /**
     Sets Up the core data stack using a model with the filename.
     
     - Parameter name: filename of the model to load.
     - Parameter bundle: bundle the model is in.
     */
    public func setupModel(name setUpName: String, bundle setUpBundle: Bundle) {
        modelFileName = setUpName
        bundle = setUpBundle
        modelURL = bundle!.url(forResource: modelFileName, withExtension: "momd")
    }
    
    // MARK: - PersistentStore
    
    /**
     Will attempt to create the persistent store and assign that persistent store to the coordinator.
     
     - Parameter deleteAndRetry: will delete the current persistent store and try creating it fresh. This can happen where lightweight migration has failed.
     */
    private func createPersistentStoreAndAssignToCoordinatorWithDeleteAndRetryOnError(coordinator: NSPersistentStoreCoordinator, deleteAndRetry: Bool) {
        var directoryCreated = true
        
        //Creating an additional directory so that when we clear we get all the files connected to Core Data
        if !FileManager.default.fileExists(atPath: storeDirectoryURL.path) {
            directoryCreated = FileManager.default.createDirectory(absoluteDirectoryPath: storeDirectoryURL.path)
        }
        
        if directoryCreated {
            var options = [String: Bool]()
            options[NSMigratePersistentStoresAutomaticallyOption] = true
            options[NSInferMappingModelAutomaticallyOption] = true
            
            do {
                try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: options)
            } catch {
                if  deleteAndRetry {
                    print("Unresolved persistent store error: \(error)")
                    print("Deleting and retrying")
                    
                    deletePersistentStore()
                    createPersistentStoreAndAssignToCoordinatorWithDeleteAndRetryOnError(coordinator: coordinator, deleteAndRetry: false)
                } else {
                    fatalError("Serious error with persistent store: \(error)")
                }
            }
        } else {
            fatalError("Unable to persistentstore due to directory issue")
        }
    }
    
    /**
     Deletes the persistent store from the file system.
     */
    private func deletePersistentStore() {
        //Need to delete the directory so that we also get the `-shm` and `-wal` files
        persistentStoreCoordinator.destroyStore()
    }
    
    // MARK: - Clear
    
    /**
     Destroys all data from core data and tears down the stack.
     */
    public func clear() {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
         deletePersistentStore()
        
        _mainManagedObjectContext?.reset()
        _mainManagedObjectContext = nil
        
        _backgroundManagedObjectContext?.reset()
        _backgroundManagedObjectContext = nil
        
        _persistentStoreCoordinator = nil
        _managedObjectModel = nil
    }
    
    /**
     Destroys all data from core data, tears down the stack and rebuilds it.
     */
    public func reset() {
        clear()
        setupModel(name: modelFileName!, bundle: bundle!)
    }
    
    // MARK: - Save
    
    /**
     Saves the managed object context that is used via the `mainManagedObjectContext` var.
     */
    public func saveMainManagedObjectContext() {
        mainManagedObjectContext.performAndWait({
            self.mainManagedObjectContext.saveAndForcePushChangesIfNeeded()
        })
    }
    
    /**
     Saves the managed object context that is set used the `NSPrivateQueueConcurrencyType` type.
     
     Saving the backgroundManagedObjectContext will cause the mainManagedObjectContext to be saved. This can result in a slightly longer save operation however the trade-off is to ensure "data correctness" over performance.
     */
    public func saveBackgroundManagedObjectContext() {
        backgroundManagedObjectContext.performAndWait({
            self.backgroundManagedObjectContext.saveAndForcePushChangesIfNeeded()
        })
    }
}

fileprivate extension NSPersistentStoreCoordinator {
    
    // MARK: - Destroy
    
    func destroyStore() {
        guard let persistentStore = persistentStores.first, let storeURL = persistentStore.url else {
            return
        }
        
        do {
            try destroyPersistentStore(at: storeURL, ofType: persistentStore.type, options: persistentStore.options)
        } catch let error {
            fatalError("failed to destroy persistent store at \(storeURL), error: \(error)")
        }
    }
}

fileprivate extension FileManager {
    
    // MARK: - Documents
    
    func documentsDirectoryURL() -> URL {
        return urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last!
    }
    
    // MARK: - Create
    
    func createDirectory(absoluteDirectoryPath: String) -> Bool {
        guard !absoluteDirectoryPath.isEmpty else {
            return false
        }
        
        let absoluteDirectoryURL = URL(fileURLWithPath: absoluteDirectoryPath)
        
        do {
            try createDirectory(at: absoluteDirectoryURL, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch {
            print("Error when creating a directory at location: \(absoluteDirectoryPath). The error was: \(error)")
            return false
        }
    }
    
    // MARK: - Delete
    
    @discardableResult
    func deleteData(absolutePath: String) -> Bool {
        guard !absolutePath.isEmpty else {
            return false
        }
        
        let absoluteURL = URL(fileURLWithPath: absolutePath)
        
        do {
            try FileManager.default.removeItem(at: absoluteURL)
            return true
        } catch {
            print("Error when deleting data at location: \(absolutePath). The error was: \(error)")
            return false
        }
    }
}

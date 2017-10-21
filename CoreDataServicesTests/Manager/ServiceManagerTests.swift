//
//  ServiceManagerTests.swift
//  CoreDataServices
//
//  Created by William Boles on 01/04/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import XCTest
import ConvenientFileManager
import CoreData

class ServiceManagerTests: XCTestCase {
    
    class NSManagedObjectContextMock: NSManagedObjectContext {
        
        var saveAndForcePushChangesIfNeededWasCalled = false
        var performAndWaitWasCalled = false
    
        override func saveAndForcePushChangesIfNeeded() {
            saveAndForcePushChangesIfNeededWasCalled = true
            super.saveAndForcePushChangesIfNeeded()
        }
        
        override func performAndWait(_ block: () -> Void) {
            performAndWaitWasCalled = true
            block()
        }
    }
    
    class ServiceManagerMock: ServiceManager {
        
        var mainManagedObjectContextToBeReturned: NSManagedObjectContextMock!
        var backgroundManagedObjectContextToBeReturned: NSManagedObjectContextMock!
        
        override var mainManagedObjectContext: NSManagedObjectContext {
            return mainManagedObjectContextToBeReturned
        }
        
        override var backgroundManagedObjectContext: NSManagedObjectContext {
            return backgroundManagedObjectContextToBeReturned
        }
    }
    
    // MARK: - Accessors
    
    var serviceManager: ServiceManager!
    var serviceManagerMock: ServiceManagerMock!
    
    var mainManagedObjectContextMock: NSManagedObjectContextMock!
    var backgroundManagedObjectContextMock: NSManagedObjectContextMock!
    
    // MARK: - TestSuiteLifecycle
    
    override func setUp() {
        super.setUp()
        
        serviceManager = ServiceManager()
        serviceManagerMock = ServiceManagerMock()
        
        mainManagedObjectContextMock = NSManagedObjectContextMock(concurrencyType: .mainQueueConcurrencyType)
        backgroundManagedObjectContextMock = NSManagedObjectContextMock(concurrencyType: .privateQueueConcurrencyType)
    }
    
    override func tearDown() {
        ServiceManager.sharedInstance.clear()
        serviceManager.clear()
        serviceManagerMock.clear()
        
        serviceManager = nil
        serviceManagerMock = nil
        mainManagedObjectContextMock = nil
        backgroundManagedObjectContextMock = nil
        
        super.tearDown()
    }
    
    // MARK: - Singleton
    
    func test_sharedInstance_returnsSameObjectOnMutlipleCalls() {
        let sharedInstanceA = ServiceManager.sharedInstance
        let sharedInstanceB = ServiceManager.sharedInstance
        
        XCTAssertEqual(sharedInstanceA, sharedInstanceB, "Same object should be returned. sharedInstanceA: \(sharedInstanceA), sharedInstanceB\(sharedInstanceB)")
    }
    
    // MARK: - SetUp
    
    func test_setupModel_persistentStoreExists() {
        let modelName = "Model"
        
        serviceManager.setupModel(name: modelName, bundle: Bundle(for: ServiceManagerTests.self))
        
        let persistentStoreExists = FileManager.fileExistsInDocumentsDirectory(relativePath: "persistent-store/\(modelName).sqlite")
        
        XCTAssertTrue(persistentStoreExists)
    }
    
    func test_setupModel_mainContextCreated() {
        serviceManager.setupModel(name: "Model", bundle: Bundle(for: ServiceManagerTests.self))
        
        XCTAssertNotNil(ServiceManager.sharedInstance.mainManagedObjectContext, "Main context should be able to be created")
    }
    
    func test_setupModel_backgroundContextCreated() {
        serviceManager.setupModel(name: "Model", bundle: Bundle(for: ServiceManagerTests.self))
        
        XCTAssertNotNil(ServiceManager.sharedInstance.backgroundManagedObjectContext, "Background context should be able to be created")
    }
    
    // MARK: - Contexts
    
    func test_mainManagedObjectContext_setUp() {
        serviceManager.setupModel(name: "Model", bundle: Bundle(for: ServiceManagerTests.self))
        
        let mainMainManagedObjectContext = serviceManager.mainManagedObjectContext
        
        XCTAssertEqual(mainMainManagedObjectContext.concurrencyType, .mainQueueConcurrencyType)
        XCTAssertNil(mainMainManagedObjectContext.parent)
        XCTAssertNil(mainMainManagedObjectContext.undoManager)
        XCTAssertNotNil(mainMainManagedObjectContext.persistentStoreCoordinator)
    }
    
    func test_backgroundManagedObjectContext_setUp() {
        serviceManager.setupModel(name: "Model", bundle: Bundle(for: ServiceManagerTests.self))
        
        let mainMainManagedObjectContext = serviceManager.mainManagedObjectContext
        let backgroundManagedObjectContext = serviceManager.backgroundManagedObjectContext
        
        XCTAssertEqual(backgroundManagedObjectContext.concurrencyType, .privateQueueConcurrencyType)
        XCTAssertEqual(backgroundManagedObjectContext.parent, mainMainManagedObjectContext)
        XCTAssertNil(backgroundManagedObjectContext.undoManager)
        XCTAssertNotNil(backgroundManagedObjectContext.persistentStoreCoordinator)
    }
    
    // MARK: - Clear
    
    func test_clear_persistentStoreDeleted() {
        let modelName = "Model"
        
        serviceManager.setupModel(name: modelName, bundle: Bundle(for: ServiceManagerTests.self))
        
        serviceManager.clear()
        
        let persistentStoreExists = FileManager.fileExistsInDocumentsDirectory(relativePath: "persistent-store/\(modelName).sqlite")
        
        XCTAssertFalse(persistentStoreExists, "Persistent store file on disk should have been deleted")
    }
    
    func test_clear_differentMainContextToWhatWasBefore() {
        serviceManager.setupModel(name: "Model", bundle: Bundle(for: ServiceManagerTests.self))
        
        let managedObjectContextBeforeClear = serviceManager.mainManagedObjectContext
        
        serviceManager.clear()
        
        let managedObjectContextAfterClear = serviceManager.mainManagedObjectContext
        
        XCTAssertFalse(managedObjectContextBeforeClear === managedObjectContextAfterClear, "A new main context should have been created after clear")
    }
    
    func test_clear_differentBackgroundContextToWhatWasBefore() {
        serviceManager.setupModel(name: "Model", bundle: Bundle(for: ServiceManagerTests.self))
        
        let managedObjectContextBeforeClear = serviceManager.backgroundManagedObjectContext
        
        serviceManager.clear()
        
        let managedObjectContextAfterClear = serviceManager.backgroundManagedObjectContext
        
        XCTAssertFalse(managedObjectContextBeforeClear == managedObjectContextAfterClear, "A new background context should have been created after clear")
    }
    
    func test_clear_differentPersistentStoreCoordinatorToWhatWasBefore() {
        serviceManager.setupModel(name: "Model", bundle: Bundle(for: ServiceManagerTests.self))
        
        let persistentStoreCoordinatorBeforeClear = serviceManager.mainManagedObjectContext.persistentStoreCoordinator!
        
        serviceManager.clear()
        
        let persistentStoreCoordinatorAfterClear = serviceManager.mainManagedObjectContext.persistentStoreCoordinator!
        
        XCTAssertFalse(persistentStoreCoordinatorBeforeClear === persistentStoreCoordinatorAfterClear, "A new persistent store coordinator should have been created after clear")
    }
    
    func test_clear_differentModelToWhatWasBefore() {
        serviceManager.setupModel(name: "Model", bundle: Bundle(for: ServiceManagerTests.self))
        
        let modelBeforeClear = serviceManager.mainManagedObjectContext.persistentStoreCoordinator!.managedObjectModel
        
        serviceManager.clear()
        
        let modelAfterClear = serviceManager.mainManagedObjectContext.persistentStoreCoordinator!.managedObjectModel
        
        XCTAssertFalse(modelBeforeClear === modelAfterClear, "A new model should have been created after clear")
    }
    
    // MARK: - Save
    
    func test_saveMainManagedObjectContext_saves() {
        serviceManagerMock.mainManagedObjectContextToBeReturned = mainManagedObjectContextMock
        
        serviceManagerMock.saveMainManagedObjectContext()
        
        XCTAssertTrue(mainManagedObjectContextMock.saveAndForcePushChangesIfNeededWasCalled)
    }
    
    func test_saveMainManagedObjectContext_performAndWaitCalled() {
        serviceManagerMock.mainManagedObjectContextToBeReturned = mainManagedObjectContextMock
        
        serviceManagerMock.saveMainManagedObjectContext()
        
        XCTAssertTrue(mainManagedObjectContextMock.performAndWaitWasCalled)
    }
    
    func test_saveBackgroundManagedObjectContext_saves() {
        serviceManagerMock.backgroundManagedObjectContextToBeReturned = backgroundManagedObjectContextMock
        
        serviceManagerMock.saveBackgroundManagedObjectContext()
        
        XCTAssertTrue(backgroundManagedObjectContextMock.saveAndForcePushChangesIfNeededWasCalled)
    }
    
    func test_saveBackgroundManagedObjectContext_performAndWaitCalled() {
        serviceManagerMock.backgroundManagedObjectContextToBeReturned = backgroundManagedObjectContextMock
        
        serviceManagerMock.saveBackgroundManagedObjectContext()
        
        XCTAssertTrue(backgroundManagedObjectContextMock.performAndWaitWasCalled)
    }
}

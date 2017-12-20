//
//  ServiceManagerTests.swift
//  CoreDataServices
//
//  Created by William Boles on 01/04/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import XCTest
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
        
        var setupModelWasCalled = false
        var clearWasCalled = false
        
        override var mainManagedObjectContext: NSManagedObjectContext {
            return mainManagedObjectContextToBeReturned
        }
        
        override var backgroundManagedObjectContext: NSManagedObjectContext {
            return backgroundManagedObjectContextToBeReturned
        }
        
        override func setupModel(name setUpName: String, bundle setUpBundle: Bundle) {
            super.setupModel(name: setUpName, bundle: setUpBundle)
            
            setupModelWasCalled = true
        }
        
        override func clear() {
            super.clear()
            
            clearWasCalled = true
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
        serviceManager.setupModel(name: "Model", bundle: Bundle(for: ServiceManagerTests.self))
        
        serviceManagerMock = ServiceManagerMock()
        serviceManagerMock.setupModel(name: "Model", bundle: Bundle(for: ServiceManagerTests.self))
        
        mainManagedObjectContextMock = NSManagedObjectContextMock(concurrencyType: .mainQueueConcurrencyType)
        backgroundManagedObjectContextMock = NSManagedObjectContextMock(concurrencyType: .privateQueueConcurrencyType)
    }
    
    override func tearDown() {
        ServiceManager.shared.clear()
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
        let sharedInstanceA = ServiceManager.shared
        let sharedInstanceB = ServiceManager.shared
        
        XCTAssertEqual(sharedInstanceA, sharedInstanceB, "Same object should be returned. sharedInstanceA: \(sharedInstanceA), sharedInstanceB\(sharedInstanceB)")
    }
    
    // MARK: - SetUp
    
    func test_setupModel_persistentStoreExists() {
        let persistentStoreExists = FileManager.default.fileExistsInDocumentsDirectory(relativePath: "persistent-store/Model.sqlite")
        
        XCTAssertTrue(persistentStoreExists)
    }
    
    func test_setupModel_mainContextCreated() {
        XCTAssertNotNil(ServiceManager.shared.mainManagedObjectContext, "Main context should be able to be created")
    }
    
    func test_setupModel_backgroundContextCreated() {
        XCTAssertNotNil(ServiceManager.shared.backgroundManagedObjectContext, "Background context should be able to be created")
    }
    
    // MARK: - Contexts
    
    func test_mainManagedObjectContext_setUp() {
        let mainMainManagedObjectContext = serviceManager.mainManagedObjectContext
        
        XCTAssertEqual(mainMainManagedObjectContext.concurrencyType, .mainQueueConcurrencyType)
        XCTAssertNil(mainMainManagedObjectContext.parent)
        XCTAssertNil(mainMainManagedObjectContext.undoManager)
        XCTAssertNotNil(mainMainManagedObjectContext.persistentStoreCoordinator)
    }
    
    func test_backgroundManagedObjectContext_setUp() {
        let mainMainManagedObjectContext = serviceManager.mainManagedObjectContext
        let backgroundManagedObjectContext = serviceManager.backgroundManagedObjectContext
        
        XCTAssertEqual(backgroundManagedObjectContext.concurrencyType, .privateQueueConcurrencyType)
        XCTAssertEqual(backgroundManagedObjectContext.parent, mainMainManagedObjectContext)
        XCTAssertNil(backgroundManagedObjectContext.undoManager)
        XCTAssertNotNil(backgroundManagedObjectContext.persistentStoreCoordinator)
    }
    
    // MARK: - Clear
    
    func test_clear_differentMainContextToWhatWasBefore() {
        let managedObjectContextBeforeClear = serviceManager.mainManagedObjectContext
        
        serviceManager.clear()
        
        let managedObjectContextAfterClear = serviceManager.mainManagedObjectContext
        
        XCTAssertFalse(managedObjectContextBeforeClear === managedObjectContextAfterClear, "A new main context should have been created after clear")
    }
    
    func test_clear_differentBackgroundContextToWhatWasBefore() {
        let managedObjectContextBeforeClear = serviceManager.backgroundManagedObjectContext
        
        serviceManager.clear()
        
        let managedObjectContextAfterClear = serviceManager.backgroundManagedObjectContext
        
        XCTAssertFalse(managedObjectContextBeforeClear == managedObjectContextAfterClear, "A new background context should have been created after clear")
    }
    
    func test_clear_differentPersistentStoreCoordinatorToWhatWasBefore() {
        let persistentStoreCoordinatorBeforeClear = serviceManager.mainManagedObjectContext.persistentStoreCoordinator!
        
        serviceManager.clear()
        
        let persistentStoreCoordinatorAfterClear = serviceManager.mainManagedObjectContext.persistentStoreCoordinator!
        
        XCTAssertFalse(persistentStoreCoordinatorBeforeClear === persistentStoreCoordinatorAfterClear, "A new persistent store coordinator should have been created after clear")
    }
    
    func test_clear_differentModelToWhatWasBefore() {
        let modelBeforeClear = serviceManager.mainManagedObjectContext.persistentStoreCoordinator!.managedObjectModel
        
        serviceManager.clear()
        
        let modelAfterClear = serviceManager.mainManagedObjectContext.persistentStoreCoordinator!.managedObjectModel
        
        XCTAssertFalse(modelBeforeClear === modelAfterClear, "A new model should have been created after clear")
    }
    
    // MARK: - Reset
    
    func test_reset() {
        serviceManagerMock.reset()
        
        XCTAssertTrue(serviceManagerMock.clearWasCalled)
        XCTAssertTrue(serviceManagerMock.setupModelWasCalled)
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

private extension FileManager {
    
    // MARK: - Documents
    
    func documentsDirectoryURL() -> URL {
        return urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).last!
    }
    
    func fileExistsInDocumentsDirectory(relativePath: String) -> Bool {
        guard !relativePath.isEmpty else {
            return false
        }
        
        let documentsDirectory = FileManager.default.documentsDirectoryURL()
        let absolutePath = documentsDirectory.appendingPathComponent(relativePath).path
        
        return FileManager.default.fileExists(absolutePath: absolutePath)
    }
    
    // MARK: - Exists
    
    func fileExists(absolutePath: String) -> Bool {
        return FileManager.default.fileExists(atPath: absolutePath)
    }
}


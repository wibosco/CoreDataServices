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

    //MARK: - TestSuiteLifecycle
    
    override func setUp() {
        super.setUp()

    }
    
    override func tearDown() {
        ServiceManager.sharedInstance.clear()
        
        super.tearDown()
    }
    
    //MARK: - Singleton
    
    func test_sharedInstance_returnsSameObjectOnMutlipleCalls() {
        let sharedInstanceA = ServiceManager.sharedInstance
        let sharedInstanceB = ServiceManager.sharedInstance
        
        XCTAssertEqual(sharedInstanceA, sharedInstanceB, "Same object should be returned. sharedInstanceA: \(sharedInstanceA), sharedInstanceB\(sharedInstanceB)")
    }
    
    //MARK: - SetUp
    
    func test_setupModel_mainContextCreated() {
        ServiceManager.sharedInstance.setupModel("Model", bundle: Bundle(for: ServiceManagerTests.self))
        
        XCTAssertNotNil(ServiceManager.sharedInstance.mainManagedObjectContext, "Main context should be able to be created")
    }
    
    func test_setupModel_backgroundContextCreated() {
        ServiceManager.sharedInstance.setupModel("Model", bundle: Bundle(for: ServiceManagerTests.self))
        
        XCTAssertNotNil(ServiceManager.sharedInstance.backgroundManagedObjectContext, "Background context should be able to be created")
    }
    
    //MARK: - Clear
    
    func test_clear_persistentStoreDeleted() {
        let modelName = "Model"
        
        ServiceManager.sharedInstance.setupModel(modelName, bundle: Bundle(for: ServiceManagerTests.self))
        
        ServiceManager.sharedInstance.clear()
        
        let persistentStoreExists = FileManager.fileExistsInDocumentsDirectory(relativePath: "persistent-store/\(modelName).sqlite")
        
        XCTAssertFalse(persistentStoreExists, "Persistent store file on disk should have been deleted")
    }
    
    func test_clear_differentMainContextToWhatWasBefore() {
        ServiceManager.sharedInstance.setupModel("Model", bundle: Bundle(for: ServiceManagerTests.self))
        
        let managedObjectContextBeforeClear = ServiceManager.sharedInstance.mainManagedObjectContext
        
        ServiceManager.sharedInstance.clear()
        
        let managedObjectContextAfterClear = ServiceManager.sharedInstance.mainManagedObjectContext
        
        XCTAssertFalse(managedObjectContextBeforeClear === managedObjectContextAfterClear, "A new main context should have been created after clear")
    }
    
    func test_clear_differentBackgroundContextToWhatWasBefore() {
        ServiceManager.sharedInstance.setupModel("Model", bundle: Bundle(for: ServiceManagerTests.self))
        
        let managedObjectContextBeforeClear = ServiceManager.sharedInstance.backgroundManagedObjectContext
        
        ServiceManager.sharedInstance.clear()
        
        let managedObjectContextAfterClear = ServiceManager.sharedInstance.backgroundManagedObjectContext
        
        XCTAssertFalse(managedObjectContextBeforeClear == managedObjectContextAfterClear, "A new background context should have been created after clear")
    }
    
    func test_clear_differentPersistentStoreCoordinatorToWhatWasBefore() {
        ServiceManager.sharedInstance.setupModel("Model", bundle: Bundle(for: ServiceManagerTests.self))
        
        let persistentStoreCoordinatorBeforeClear = ServiceManager.sharedInstance.mainManagedObjectContext.persistentStoreCoordinator!
        
        ServiceManager.sharedInstance.clear()
        
        let persistentStoreCoordinatorAfterClear = ServiceManager.sharedInstance.mainManagedObjectContext.persistentStoreCoordinator!
        
        XCTAssertFalse(persistentStoreCoordinatorBeforeClear === persistentStoreCoordinatorAfterClear, "A new persistent store coordinator should have been created after clear")
    }
    
    func test_clear_differentModelToWhatWasBefore() {
        ServiceManager.sharedInstance.setupModel("Model", bundle: Bundle(for: ServiceManagerTests.self))
        
        let modelBeforeClear = ServiceManager.sharedInstance.mainManagedObjectContext.persistentStoreCoordinator!.managedObjectModel
        
        ServiceManager.sharedInstance.clear()
        
        let modelAfterClear = ServiceManager.sharedInstance.mainManagedObjectContext.persistentStoreCoordinator!.managedObjectModel
        
        XCTAssertFalse(modelBeforeClear === modelAfterClear, "A new model should have been created after clear")
    }
}

//
//  NSManagedObjectContext+SaveTests.swift
//  CoreDataServices
//
//  Created by William Boles on 12/07/2017.
//  Copyright © 2017 Boles. All rights reserved.
//

import XCTest
import CoreData

class NSManagedObjectContext_SaveTests: XCTestCase {
    
    class NSManagedObjectContextMock:  NSManagedObjectContext {
        
        var hasChangesToBeReturned = false
        
        var saveWasCalled = false
        var saveAndForcePushChangesIfNeededWasCalled = false
        var processPendingChangesWasCalled = false
        
        override var hasChanges: Bool {
            get {
                return hasChangesToBeReturned
            }
        }
        
        override func save() throws {
            saveWasCalled = true
        }
        
        override func processPendingChanges() {
            processPendingChangesWasCalled = true
        }
        
        override func saveAndForcePushChangesIfNeeded() {
            saveAndForcePushChangesIfNeededWasCalled = true
            super.saveAndForcePushChangesIfNeeded()
        }
    }
    
    // MARK: - Accessors

    var managedObjectContextMock: NSManagedObjectContextMock!
    var parentManagedObjectContextMock: NSManagedObjectContextMock!
    var childManagedObjectContextMock: NSManagedObjectContextMock!
    
    // MARK: - TestSuiteLifecycle
    
    override func setUp() {
        super.setUp()
        
        managedObjectContextMock = NSManagedObjectContextMock(concurrencyType: .mainQueueConcurrencyType)
        
        parentManagedObjectContextMock = NSManagedObjectContextMock(concurrencyType: .mainQueueConcurrencyType)
        
        childManagedObjectContextMock = NSManagedObjectContextMock(concurrencyType: .privateQueueConcurrencyType)
        childManagedObjectContextMock.parent = parentManagedObjectContextMock
    }
    
    override func tearDown() {
        managedObjectContextMock = nil
        parentManagedObjectContextMock = nil
        childManagedObjectContextMock = nil
        
        super.tearDown()
    }
    
    //MARK: - Changes
    
    func test_saveAndForcePushChangesIfNeeded_noChanges() {
        managedObjectContextMock.hasChangesToBeReturned = false
        
        managedObjectContextMock.saveAndForcePushChangesIfNeeded()
        
        XCTAssertFalse(managedObjectContextMock.saveWasCalled)
    }
    
    func test_saveAndForcePushChangesIfNeeded_changes() {
        managedObjectContextMock.hasChangesToBeReturned = true
        
        managedObjectContextMock.saveAndForcePushChangesIfNeeded()
        
        XCTAssertTrue(managedObjectContextMock.saveWasCalled)
    }
    
    // MARK: - Process
    
    func test_saveAndForcePushChangesIfNeeded_forceProcessPendingChanges() {
        managedObjectContextMock.hasChangesToBeReturned = true
        
        managedObjectContextMock.saveAndForcePushChangesIfNeeded()
        
        XCTAssertTrue(managedObjectContextMock.processPendingChangesWasCalled)
    }
    
    // MARK: - Child
    
    func test_saveAndForcePushChangesIfNeeded_parentCalled() {
        childManagedObjectContextMock.saveAndForcePushChangesIfNeeded()
        
        XCTAssertFalse(parentManagedObjectContextMock.processPendingChangesWasCalled)
    }

}

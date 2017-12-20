//
//  NSManagedObjectContext+CountTests.swift
//  CoreDataServices
//
//  Created by William Boles on 01/04/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import XCTest
import CoreData

class NSManagedObjectContext_CountTests: XCTestCase {
    
    // MARK: - TestSuiteLifecycle
    
    override func setUp() {
        super.setUp()
        
        /*---------------*/
        
        ServiceManager.shared.setupModel(name: "Model", bundle: Bundle(for: ServiceManagerTests.self))
        
        /*---------------*/
        
        let managedObjectA = NSEntityDescription.insertNewObject(entityClass:Test.self, managedObjectContext: ServiceManager.shared.mainManagedObjectContext)
        
        managedObjectA.name = "Bob"
        
        let managedObjectB = NSEntityDescription.insertNewObject(entityClass:Test.self, managedObjectContext: ServiceManager.shared.mainManagedObjectContext)
        
        managedObjectB.name = "Toby"
        
        let managedObjectC = NSEntityDescription.insertNewObject(entityClass:Test.self, managedObjectContext: ServiceManager.shared.mainManagedObjectContext)
        
        managedObjectC.name = "Bobby"
        
        /*---------------*/
        
        let managedObjectShouldNotBeReturned = NSEntityDescription.insertNewObject(entityClass:AdditionalTest.self, managedObjectContext: ServiceManager.shared.mainManagedObjectContext)
        
        managedObjectShouldNotBeReturned.title = "Bobsen"
        
        /*---------------*/
        
        ServiceManager.shared.saveMainManagedObjectContext()
    }
    
    override func tearDown() {
        ServiceManager.shared.clear()
        
        super.tearDown()
    }
    
    // MARK: - Total
    
    func test_retrieveEntriesCount_total() {
        let total = ServiceManager.shared.mainManagedObjectContext.retrieveEntriesCount(entityClass: Test.self)
        
        XCTAssertEqual(total, 3, "Should have returned all entries for \(String(describing: Test.self))")
    }
    
    // MARK: - Predicate
    
    func test_retrieveEntriesCountWithPredicate_total() {
        let predicate = NSPredicate(format: "name CONTAINS[cd] 'bob'")
        
        let total = ServiceManager.shared.mainManagedObjectContext.retrieveEntriesCount(entityClass: Test.self, predicate: predicate)
        
        XCTAssertEqual(total, 2, "Should have returned all entries that match the predicate: \(predicate)")
    }
}

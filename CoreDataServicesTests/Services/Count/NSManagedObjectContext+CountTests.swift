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
    
    //MARK: - TestSuiteLifecycle
    
    override func setUp() {
        super.setUp()
        
        /*---------------*/
        
        ServiceManager.sharedInstance.setupModel(name: "Model", bundle: Bundle(for: ServiceManagerTests.self))
        
        /*---------------*/
        
        let managedObjectA = NSEntityDescription.insertNewObject(entityClass:Test.self, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext)
        
        managedObjectA.name = "Bob"
        
        let managedObjectB = NSEntityDescription.insertNewObject(entityClass:Test.self, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext)
        
        managedObjectB.name = "Toby"
        
        let managedObjectC = NSEntityDescription.insertNewObject(entityClass:Test.self, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext)
        
        managedObjectC.name = "Bobby"
        
        /*---------------*/
        
        let managedObjectShouldNotBeReturned = NSEntityDescription.insertNewObject(entityClass:AdditionalTest.self, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext)
        
        managedObjectShouldNotBeReturned.title = "Bobsen"
        
        /*---------------*/
        
        ServiceManager.sharedInstance.saveMainManagedObjectContext()
    }
    
    override func tearDown() {
        ServiceManager.sharedInstance.clear()
        
        super.tearDown()
    }
    
    //MARK: - Total
    
    func test_retrieveEntriesCount_total() {
        let total = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveEntriesCount(entityClass: Test.self)
        
        XCTAssertEqual(total, 3, "Should have returned all entries for \(String(describing: Test.self))")
    }
    
    //MARK: - Predicate
    
    func test_retrieveEntriesCountWithPredicate_total() {
        let predicate = NSPredicate(format: "name CONTAINS[cd] 'bob'")
        
        let total = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveEntriesCount(entityClass: Test.self, predicate: predicate)
        
        XCTAssertEqual(total, 2, "Should have returned all entries that match the predicate: \(predicate)")
    }
}

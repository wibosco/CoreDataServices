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
    
    //MARK: TestSuiteLifecycle
    
    override func setUp() {
        super.setUp()
        
        /*---------------*/
        
        ServiceManager.sharedInstance.setupModel("Model", bundle: Bundle(for: ServiceManagerTests.self))
        
        /*---------------*/
        
        let managedObjectA = NSEntityDescription.insertNewObjectForEntity(entityClass:Test.self, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext) as! Test
        
        managedObjectA.name = "Bob"
        
        let managedObjectB = NSEntityDescription.insertNewObjectForEntity(entityClass:Test.self, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext) as! Test
        
        managedObjectB.name = "Toby"
        
        let managedObjectC = NSEntityDescription.insertNewObjectForEntity(entityClass:Test.self, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext) as! Test
        
        managedObjectC.name = "Bobby"
        
        /*---------------*/
        
        let managedObjectShouldNotBeReturned = NSEntityDescription.insertNewObjectForEntity(entityClass:AdditionalTest.self, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext) as! AdditionalTest
        
        managedObjectShouldNotBeReturned.title = "Bobsen"
        
        /*---------------*/
        
        ServiceManager.sharedInstance.saveMainManagedObjectContext()
    }
    
    override func tearDown() {
        ServiceManager.sharedInstance.clear()
        
        super.tearDown()
    }
    
    //MARK: Total
    
    func test_retrieveEntriesCount_total() {
        let total = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveEntriesCount(entityClass: Test.self)
        
        XCTAssertEqual(total, 3, "Should have returned all entries for \(String(describing: Test.self))")
    }
    
    //MARK: Predicate
    
    func test_retrieveEntriesCountWithPredicate_total() {
        let predicate = NSPredicate(format: "name CONTAINS[cd] 'bob'")
        
        let total = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveEntriesCount(entityClass: Test.self, predicate: predicate)
        
        XCTAssertEqual(total, 2, "Should have returned all entries that match the predicate: \(predicate)")
    }
}

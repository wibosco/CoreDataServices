//
//  NSManagedObjectContext+DeleteTests.swift
//  CoreDataServices
//
//  Created by William Boles on 01/04/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import XCTest
import CoreData

class NSManagedObjectContext_DeleteTests: XCTestCase {
    
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
    
    //MARK: All
    
    func test_deleteEntries_deleteAll() {
        ServiceManager.sharedInstance.mainManagedObjectContext.deleteEntries(entityClass: Test.self)
        
        let totalRemaining = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveEntriesCount(entityClass: Test.self)
        
        XCTAssertEqual(totalRemaining, 0, "Shouldn't have returned any entries for \(String(describing: Test.self))")
    }
    
    //MARK: Predciate
    
    func test_deleteEntries_predicate() {
        let predicate = NSPredicate(format: "name CONTAINS[cd] 'bob'")
        
        ServiceManager.sharedInstance.mainManagedObjectContext.deleteEntries(entityClass: Test.self, predicate: predicate)
        
        let totalRemaining = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveEntriesCount(entityClass: Test.self)
        
        XCTAssertEqual(totalRemaining, 1, "Should have deleted those entries matching the predicate \(predicate))")
    }
}

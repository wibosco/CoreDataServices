//
//  NSEntityDescription+EntityDescriptionTests.swift
//  CoreDataServices
//
//  Created by William Boles on 01/04/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import XCTest
import CoreData

class NSEntityDescription_EntityDescriptionTests: XCTestCase {
    
    //MARK: TestSuiteLifecycle
    
    override func setUp() {
        super.setUp()
        
        ServiceManager.sharedInstance.setupModel("Model", bundle: NSBundle(forClass: ServiceManagerTests.self))
    }
    
    override func tearDown() {
        ServiceManager.sharedInstance.clear()
        
        super.tearDown()
    }
    
    //MARK: Retrieval
    
    func test_entityFor_entityDescriptionReturned() {
        let entityDescription = NSEntityDescription.entityFor(Test.self, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext)
        
        XCTAssertEqual(entityDescription!.name!, String(Test), "Should have an NSEntityDescription instance for \(String(Test))")
    }
    
    //MARK: Insert
    
    func test_insertNewObjectForEntity_inserted() {
        NSEntityDescription.insertNewObjectForEntity(Test.self, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext)
        
        XCTAssertEqual(ServiceManager.sharedInstance.mainManagedObjectContext.retrieveEntriesCount(Test), 1, "Should have one row in the \(String(Test)) entity")
    }
    
    func test_insertNewObjectForEntity_returnType() {
        let managedObject = NSEntityDescription.insertNewObjectForEntity(Test.self, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext)
        
        XCTAssertTrue(managedObject!.isKindOfClass(Test.self), "Should have returned object of type: \(String(Test))")
    }
}

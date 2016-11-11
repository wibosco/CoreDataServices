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
    
    //MARK: - TestSuiteLifecycle
    
    override func setUp() {
        super.setUp()
        
        ServiceManager.sharedInstance.setupModel(name: "Model", bundle: Bundle(for: ServiceManagerTests.self))
    }
    
    override func tearDown() {
        ServiceManager.sharedInstance.clear()
        
        super.tearDown()
    }
    
    //MARK: - Retrieval
    
    func test_entityDescriptionFor_entityDescriptionReturned() {
        let entityDescription = NSEntityDescription.entityDescriptionFor(entityClass: Test.self, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext)
        
        XCTAssertEqual(entityDescription.name!, String(describing: Test.self), "Should have an NSEntityDescription instance for \(String(describing: Test.self))")
    }
    
    //MARK: - Insert
    
    func test_insertNewObjectForEntity_inserted() {
        NSEntityDescription.insertNewObjectForEntity(entityClass:Test.self, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext)
        
        XCTAssertEqual(ServiceManager.sharedInstance.mainManagedObjectContext.retrieveEntriesCount(entityClass: Test.self), 1, "Should have one row in the \(String(describing: Test.self)) entity")
    }
    
    func test_insertNewObjectForEntity_returnType() {
        let managedObject = NSEntityDescription.insertNewObjectForEntity(entityClass:Test.self, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext)
        
        XCTAssertTrue(managedObject.isKind(of: Test.self), "Should have returned object of type: \(String(describing: Test.self))")
    }
}

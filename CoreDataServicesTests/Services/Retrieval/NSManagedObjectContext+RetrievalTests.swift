//
//  NSManagedObjectContext+RetrievalTests.swift
//  CoreDataServices
//
//  Created by William Boles on 01/04/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import XCTest
import CoreData

class NSManagedObjectContext_RetrievalTests: XCTestCase {
    
    //MARK: - Accessors
    
    var managedObjectA: Test?
    var managedObjectB: Test?
    var managedObjectC: Test?
    var managedObjectD: Test?
    
    //MARK: - TestSuiteLifecycle
    
    override func setUp() {
        super.setUp()
        
        /*---------------*/
        
        ServiceManager.sharedInstance.setupModel(name: "Model", bundle: Bundle(for: ServiceManagerTests.self))
        
        /*---------------*/
        
        self.managedObjectA = NSEntityDescription.insertNewObject(entityClass:Test.self, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext)
        
        self.managedObjectA!.name = "Bob"
        self.managedObjectA!.testID = 19
        
        self.managedObjectB = NSEntityDescription.insertNewObject(entityClass:Test.self, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext)
        
        self.managedObjectB!.name = "Toby"
        self.managedObjectB!.testID = 3
        
        self.managedObjectC = NSEntityDescription.insertNewObject(entityClass:Test.self, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext)
        
        self.managedObjectC!.name = "Bob"
        self.managedObjectC!.testID = 8
        
        self.managedObjectD = NSEntityDescription.insertNewObject(entityClass:Test.self, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext)
        
        self.managedObjectD!.name = "Gaby"
        self.managedObjectD!.testID = 1
        
        /*---------------*/
        
        let managedObjectShouldNotBeReturned = NSEntityDescription.insertNewObject(entityClass:AdditionalTest.self, managedObjectContext: ServiceManager.sharedInstance.mainManagedObjectContext)
        
        managedObjectShouldNotBeReturned.title = "Bobsen"
        
        /*---------------*/
        
        ServiceManager.sharedInstance.saveMainManagedObjectContext()
    }
    
    override func tearDown() {
        self.managedObjectA = nil
        self.managedObjectB = nil
        self.managedObjectC = nil
        self.managedObjectD = nil
        
        ServiceManager.sharedInstance.clear()
        
        super.tearDown()
    }
    
    //MARK: - Retrieval - ClassOnly
    
    func test_retrieveEntriesClassOnly_all() {
        let managedObjects = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveEntries(entityClass: Test.self)
        
        XCTAssertEqual(managedObjects.count, 4, "Should have returned all entries")
    }
    
    //MARK: - Retrieval - ClassAndPredicate
    
    func test_retrieveEntriesClassAndPredicate_all() {
        let predicate = NSPredicate(format: "name CONTAINS[cd] 'bob'")
        
        let managedObjects = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveEntries(entityClass: Test.self, predicate: predicate)
        
        XCTAssertEqual(managedObjects.count, 2, "Should have returned all entries matching predicate")
    }
    
    //MARK: - Retrieval - ClassAndSortDescriptor
    
    func test_retrieveEntriesClassAndSortDescriptor_all() {
        let idSort = NSSortDescriptor(key: "testID", ascending: true)
        
        let managedObjects = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveEntries(entityClass: Test.self, sortDescriptors: [idSort])
        
        let sortedArray = [self.managedObjectD!, self.managedObjectB!, self.managedObjectC!, self.managedObjectA!]
        
        XCTAssertEqual(managedObjects, sortedArray, "Both array should have the same content, in the same order")
    }
    
    func test_retrieveEntriesClassAndMultipleSortDescriptor_all() {
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        let idSort = NSSortDescriptor(key: "testID", ascending: true)
        
        let managedObjects = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveEntries(entityClass: Test.self, sortDescriptors: [nameSort, idSort])
        
        let sortedArray = [self.managedObjectC!, self.managedObjectA!, self.managedObjectD!, self.managedObjectB!]
        
        XCTAssertEqual(managedObjects, sortedArray, "Both array should have the same content, in the same order")
    }
    
    //MARK: - Retrieval - ClassAndSortDescriptorAndPredicate
    
    func test_retrieveEntriesClassAndSortDescriptorAndPredicate_all() {
        let predicate = NSPredicate(format: "name CONTAINS[cd] 'bob'")
        let idSort = NSSortDescriptor(key: "testID", ascending: false)
        
        let managedObjects = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveEntries(entityClass: Test.self, predicate: predicate, sortDescriptors: [idSort])
        
        let sortedArray = [self.managedObjectA!, self.managedObjectC!]
        
        XCTAssertEqual(managedObjects, sortedArray, "Both array should have the same content, in the same order")
    }
    
    //MARK: - Retrieval - ClassAndSortDescriptorAndPredicateAndLimit
    
    func test_retrieveEntriesClassAndSortDescriptorAndPredicateAndLimit_count() {
        let predicate = NSPredicate(format: "name CONTAINS[cd] 'bob'")
        let idSort = NSSortDescriptor(key: "testID", ascending: false)
        
        let managedObjects = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveEntries(entityClass: Test.self, predicate: predicate, sortDescriptors: [idSort], fetchBatchSize: 0, fetchLimit: 1)
 
        XCTAssertEqual(managedObjects.count, 1, "Only the first object should be returned")
    }
    
    func test_retrieveEntriesClassAndSortDescriptorAndPredicateAndLimit_objectReturned() {
        let predicate = NSPredicate(format: "name CONTAINS[cd] 'bob'")
        let idSort = NSSortDescriptor(key: "testID", ascending: false)
        
        let managedObjects = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveEntries(entityClass: Test.self, predicate: predicate, sortDescriptors: [idSort], fetchBatchSize: 0, fetchLimit: 1)
        
        XCTAssertEqual(managedObjects[0], self.managedObjectA!, "Object returned should match")
    }
    
    //MARK: - Retrieval - Single - ClassOnly
    
    func test_retrieveEntryClassOnly_type() {
        let managedObject = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveFirstEntry(entityClass: Test.self)
        
        XCTAssertTrue(managedObject!.isKind(of: Test.self), "Entity should be of the type requested")
    }
    
    //MARK: - Retrieval - Single - ClassAndSortDescriptor
    
    func test_retrieveEntryClassAndSortDescriptor_type() {
        let idSort = NSSortDescriptor(key: "testID", ascending: true)
        
        let managedObject = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveFirstEntry(entityClass: Test.self, sortDescriptors: [idSort])
        
        XCTAssertEqual(managedObject, self.managedObjectD, "Object returned should match")
    }
    
    func test_retrieveEntryClassAndSortDescriptors_type() {
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        let idSort = NSSortDescriptor(key: "testID", ascending: false)
        
        let managedObject = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveFirstEntry(entityClass: Test.self, sortDescriptors: [nameSort, idSort])
        
        XCTAssertEqual(managedObject, self.managedObjectA, "Object returned should match")
    }
    
    //MARK: - Retrieval - Single - ClassAndPredicate
    
    func test_retrieveEntryClassAndPredicate_type() {
        let predicate = NSPredicate(format: "name CONTAINS[cd] 'bob'")
        
        let managedObject = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveFirstEntry(entityClass: Test.self, predicate: predicate)
        
        XCTAssertNotNil(managedObject, "Object should have been returned")
    }
    
    //MARK: - Retrieval - Single - ClassAndPredicateAndSortDescriptor
    
    func test_retrieveEntryClassAndPredicateAndSortDescriptor_type() {
        let idSort = NSSortDescriptor(key: "testID", ascending: false)
        let predicate = NSPredicate(format: "name CONTAINS[cd] 'bob'")
        
        let managedObject = ServiceManager.sharedInstance.mainManagedObjectContext.retrieveFirstEntry(entityClass: Test.self, predicate: predicate , sortDescriptors: [idSort])
        
        XCTAssertEqual(managedObject, self.managedObjectA, "Object returned should match")
    }
}

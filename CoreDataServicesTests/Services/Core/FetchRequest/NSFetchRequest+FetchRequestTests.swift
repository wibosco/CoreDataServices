//
//  NSFetchRequest+FetchRequestTests.swift
//  CoreDataServices
//
//  Created by William Boles on 01/04/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import XCTest
import CoreData

class NSFetchRequest_FetchRequestTests: XCTestCase {
    
    //MARK: TestSuiteLifecycle
    
    override func setUp() {
        super.setUp()
        
        ServiceManager.sharedInstance.setupModel("Model", bundle: NSBundle(forClass: ServiceManagerTests.self))
    }
    
    override func tearDown() {
        ServiceManager.sharedInstance.clear()
        
        super.tearDown()
    }
    
    //MARK: Class
    
    func test_fetchRequest_entityClass() {
        let fetchRequest = NSFetchRequest.fetchRequest(Test.self)
        
        XCTAssertEqual(fetchRequest?.entityName, String(Test), "Should have a NSFetchRequest instance for \(String(Test))")
    }
}

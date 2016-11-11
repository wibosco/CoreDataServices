//
//  NSEntityDescription+EntityDescription.swift
//  CoreDataServices
//
//  Created by William Boles on 01/04/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import Foundation
import CoreData

/**
 An extension that extends `NSEntityDescription` to add functions that focus on avoiding passing "magic strings" and instead focuses on passing around a class.
 
 In order to use this category you will need to create a subclasses of `NSManagedObject` rather than using KVO.
 */
public extension NSEntityDescription {
    
    //MARK: Retrieval
    
    /**
     Retrieves `NSEntityDescription` instance for core data entity class.
     
     - Parameter entityClass: class value for the entity in core data.
     - Parameter managedObjectContext: the context used to access the entries.
     
     - Returns: `NSEntityDescription` instance of entityClass passed in.
     */
    public class func entityDescriptionFor(entityClass: AnyClass, managedObjectContext: NSManagedObjectContext) -> NSEntityDescription {
        let entityName = String.stripModule(entityClass: entityClass)!
        
        NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
        
        //if entityName does not exist we want this statement to throw an exception and crash the app - fail fast
        return NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)!
    }
    
    //MARK: Insertion
    
    /**
     Inserts instance of entity class into core data.
     
     - Parameter entityClass: class value for the entity in core data.
     - Parameter managedObjectContext: the context used to access the entries.
     
     - Returns: `NSManagedObject` instance of entityClass passed in.
     */
    @discardableResult
    public class func insertNewObjectForEntity(entityClass: AnyClass, managedObjectContext: NSManagedObjectContext) -> NSManagedObject {
        let entityName = String.stripModule(entityClass: entityClass)!
        
        //if entityName does not exist we want this statement to throw an exception and crash the app - fail fast
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: managedObjectContext)
    }
}

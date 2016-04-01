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
     
     - param entityClass: class value for the entity in core data.
     - param managedObjectContext: the context used to access the entries.
     
     - returns: `NSEntityDescription` instance of entityClass passed in.
     */
    public class func entityFor(entityClass: AnyClass, managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        var entityDescription: NSEntityDescription?
        
        if let entityName = String(entityClass).componentsSeparatedByString(".").last {
            entityDescription = NSEntityDescription.entityForName(entityName, inManagedObjectContext: managedObjectContext)
        }
        
        return entityDescription
    }
    
    //MARK: Insertion
    
    /**
     Inserts instance of entity class into core data.
     
     - param entityClass: class value for the entity in core data.
     - param managedObjectContext: the context used to access the entries.
     
     - returns: `NSManagedObject` instance of entityClass passed in.
     */
    public class func insertNewObjectForEntity(entityClass: AnyClass, managedObjectContext: NSManagedObjectContext) -> NSManagedObject? {
        var managedObject: NSManagedObject?
        
        if let entityName = String(entityClass).componentsSeparatedByString(".").last {
            managedObject = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: managedObjectContext)
        }
        
        return managedObject
    }
}
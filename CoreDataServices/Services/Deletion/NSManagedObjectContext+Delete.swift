//
//  NSManagedObjectContext+Delete.swift
//  CoreDataServices
//
//  Created by William Boles on 01/04/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import Foundation
import CoreData

/**
 An extension that extends `NSManagedObjectContext` to provide convenience functions related to deleting entries/rows/objects in your Core Data Entity.
 
 In order to use this category you will need to create a subclasses of `NSManagedObject` rather than using KVO.
 */
public extension NSManagedObjectContext {
    
    /**
     Deletes entries/rows/objects from core data entity.
     
     - Parameter entityClass: a class value for the entity in core data.
     */
    @objc(cds_deleteEntriesForEntityClass:)
    public func deleteEntries(entityClass: AnyClass) {
        self.deleteEntries(entityClass, predicate: nil)
    }
    
    /**
     Deletes entries/rows/objects from core data entity that matches the predicate passed.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter predicate: a predicate used to limit the entries deleted.
     */
    @objc(cds_deleteEntriesForEntityClass:predicate:)
    public func deleteEntries(entityClass: AnyClass, predicate: NSPredicate?) {
        
        var managedObjects: Array<NSManagedObject>
        
        if predicate != nil {
            managedObjects = self.retrieveEntries(entityClass, predicate: predicate!)
        } else {
            managedObjects = self.retrieveEntries(entityClass)
        }
        
        for managedObject in managedObjects {
            self.deleteObject(managedObject)
        }
    }
    
}
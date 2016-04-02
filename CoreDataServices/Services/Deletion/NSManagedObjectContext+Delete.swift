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
     
     - param entityClass: a class value for the entity in core data.
     - param saveAfterDeletion: used to determine if after deletion the managed object context should be saved. Especially useful when deleting objects on a background thread and you want to perform our tasks before saving/merging into the main `NSManagedObjectContext`.
     */
    @objc(cds_deleteEntriesForEntityClass:)
    public func deleteEntries(entityClass: AnyClass) {
        self.deleteEntries(entityClass, predicate: nil)
    }
    
    /**
     Deletes entries/rows/objects from core data entity that matches the predicate passed.
     
     - param entityClass: a class value for the entity in core data.
     - param predicate: a predicate used to limit the entries deleted.
     - param saveAfterDeletion: used to determine if after deletion the managed object context should be saved. Especially useful when deleting objects on a background thread and you want to perform our tasks before saving/merging into the main `NSManagedObjectContext`.
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
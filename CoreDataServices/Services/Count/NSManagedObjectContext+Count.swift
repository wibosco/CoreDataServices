//
//  NSManagedObjectContext+Count.swift
//  CoreDataServices
//
//  Created by William Boles on 01/04/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import Foundation
import CoreData

/**
 A extension that extends `NSManagedObjectContext` to provide convenience functions related to counting the number of entries/rows/objects in your Core Data Entity.
 
 In order to use this category you will need to create a subclasses of `NSManagedObject` rather than using KVO.
 */
public extension NSManagedObjectContext {
    
    /**
     Retrieves the count of entries.
     
     -param entityClass: a class value for the entity in core data.
     
     - returns: `NSUInteger` count of entries for this class/entity.
     */
    @objc(cds_retrieveEntriesCountForEntityClass:)
    public func retrieveEntriesCount(entityClass: AnyClass) -> Int {
        return self.retrieveEntriesCount(entityClass, predicate: nil)
    }
    
    /**
     Retrieves the count of entries that match the provided predicate's conditions.
     
     - param entityClass: a class value for the entity in core data.
     - param predicate: a predicate used to limit the entries returned.
     
     - returns: `NSUInteger` count of entries that match provided predicate.
     */
    @objc(cds_retrieveEntriesCountForEntityClass:predicate:)
    public func retrieveEntriesCount(entityClass: AnyClass, predicate: NSPredicate?) -> Int {
        var count = 0
        
        if let fetchRequest = NSFetchRequest.fetchRequest(entityClass) {
            if predicate != nil {
                fetchRequest.predicate = predicate
            }
            
            var error: NSError?
            
            count = self.countForFetchRequest(fetchRequest, error: &error)
            
            if error != nil {
                print("Error attempting to retrieve entries count from entity: \(entityClass) with pred: \(predicate). Error: \(error!.description)")
            }
        }
        
        return count
    }
}
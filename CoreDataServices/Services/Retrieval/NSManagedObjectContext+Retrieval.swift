//
//  NSManagedObjectContext+Retrieval.swift
//  CoreDataServices
//
//  Created by William Boles on 01/04/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import Foundation
import CoreData

/**
 An extension that extends `NSManagedObjectContext` to provide convenience functions related to retrieving data from a Core Data Entity.
 
 In order to use this category you will need to create a subclasses of `NSManagedObject` rather than using KVO.
 */
public extension NSManagedObjectContext {
    
    //MARK: Multiple
    
    /**
     Retrieves top ordered entries for an entity in core data that match the provided predicate's conditions within batches.
     
     - param entityClass: a class value for the entity in core data.
     - param predicate: a predicate used to limit the entries returned.
     - param sortDescriptors: an array containing sorting values to be applied to this request.
     - param fetchBatchSize: limits the number of returned objects in each batch.
     - param fetchLimit : limts the total number of returned objects.
     
     - returns: `Array` of `NSManagedObjects`.
     */
    public func retrieveEntries(entityClass: AnyClass, predicate: NSPredicate?, sortDescriptors: Array<NSSortDescriptor>?, fetchBatchSize: Int?, fetchLimit: Int?) -> Array<NSManagedObject> {
        
        var managedObjects: Array<NSManagedObject> = []
        
        if let fetchRequest = NSFetchRequest.fetchRequest(entityClass) {
            if predicate != nil {
                fetchRequest.predicate = predicate
            }
            
            if sortDescriptors != nil && sortDescriptors!.count > 0 {
                fetchRequest.sortDescriptors = sortDescriptors
            }
            
            if fetchBatchSize != nil && fetchBatchSize > 0 {
                fetchRequest.fetchBatchSize = fetchBatchSize!
            }
            
            if fetchLimit != nil && fetchLimit > 0 {
                fetchRequest.fetchLimit = fetchLimit!
            }
            
            do {
                try managedObjects = self.executeFetchRequest(fetchRequest) as! Array<NSManagedObject>
            } catch let error as NSError {
                print("Error attempting to retrieve entries from class \(entityClass), predicate \(predicate), sortDescriptors \(sortDescriptors), fetchBatchSize \(fetchBatchSize), fetchLimit \(fetchLimit), managedObjectContext \(self). Error: \(error.description)")
            }
        }
        
        return managedObjects
    }
    

    /**
     Retrieves ordered entries for an entity in core data that match the provided predicate's conditions within batches.
     
     - param entityClass: a class value for the entity in core data.
     - param predicate: a predicate used to limit the entries returned.
     - param sortDescriptors: an array containing sorting values to be applied to this request.
     - param fetchBatchSize: limits the number of returned objects in each batch.
     
     - returns: `Array` of `NSManagedObjects`.
     */
    public func retrieveEntries(entityClass: AnyClass, predicate: NSPredicate, sortDescriptors: Array<NSSortDescriptor>, fetchBatchSize: Int) -> Array<NSManagedObject> {
        return self.retrieveEntries(entityClass, predicate: predicate, sortDescriptors: sortDescriptors, fetchBatchSize: fetchBatchSize, fetchLimit: nil)
    }
    
    /**
     Retrieves ordered entries for an entity in core data that match the provided predicate's conditions.
     
     - param entityClass: a class value for the entity in core data.
     - param predicate: a predicate used to limit the entries returned.
     - param sortDescriptors: an array containing sorting values to be applied to this request.
     
     - returns: `Array` of `NSManagedObjects`.
     */
    public func retrieveEntries(entityClass: AnyClass, predicate: NSPredicate, sortDescriptors: Array<NSSortDescriptor>) -> Array<NSManagedObject> {
        return self.retrieveEntries(entityClass, predicate: predicate, sortDescriptors: sortDescriptors, fetchBatchSize: nil, fetchLimit: nil)
    }
    
    /**
     Retrieves all entries for an entity in core data that match the provided predicate's conditions.
     
     - param entityClass: a class value for the entity in core data.
     - param predicate: a predicate used to limit the entries returned.
     
     - returns: `Array` of `NSManagedObjects`.
     */
    public func retrieveEntries(entityClass: AnyClass, predicate: NSPredicate) -> Array<NSManagedObject> {
        return self.retrieveEntries(entityClass, predicate: predicate, sortDescriptors: nil, fetchBatchSize: nil, fetchLimit: nil)
    }
    
    /**
     Retrieves all entries for an entity in core data within batches.
     
     - param entityClass: a class value for the entity in core data.
     - param fetchBatchSize: limits the number of returned objects in each batch.
     
     - returns: `Array` of `NSManagedObjects`.
     */
    public func retrieveEntries(entityClass: AnyClass, fetchBatchSize: Int) -> Array<NSManagedObject> {
        return self.retrieveEntries(entityClass, predicate: nil, sortDescriptors: nil, fetchBatchSize: fetchBatchSize, fetchLimit: nil)
    }
    
    /**
     Retrieves all entries for an entity in core data that match the provided predicate's conditions within batches.
     
     - param entityClass: a class value for the entity in core data.
     - param predicate: a predicate used to limit the entries returned.
     - param fetchBatchSize: limits the number of returned objects in each batch.
     
     - returns: `Array` of `NSManagedObjects`.
     */
    public func retrieveEntries(entityClass: AnyClass, predicate: NSPredicate, fetchBatchSize: Int) -> Array<NSManagedObject> {
        return self.retrieveEntries(entityClass, predicate: predicate, sortDescriptors: nil, fetchBatchSize: fetchBatchSize, fetchLimit: nil)
    }
    
    /**
     Retrieves ordered entries for an entity in core data.
     
     - param entityClass: a class value for the entity in core data.
     - param sortDescriptors: an array containing sorting values to be applied to this request.
     
     - returns: `Array` of `NSManagedObjects`.
     */
    public func retrieveEntries(entityClass: AnyClass, sortDescriptors: Array<NSSortDescriptor>) -> Array<NSManagedObject> {
        return self.retrieveEntries(entityClass, predicate: nil, sortDescriptors: sortDescriptors, fetchBatchSize: nil, fetchLimit: nil)
    }
    
    /**
     Retrieves ordered entries for an entity in core data within batches.
     
     - param entityClass: a class value for the entity in core data.
     - param sortDescriptors: an array containing sorting values to be applied to this request.
     - param fetchBatchSize: limits the number of returned objects in each batch.
     
     - returns: `Array` of `NSManagedObjects`.
     */
    public func retrieveEntries(entityClass: AnyClass, sortDescriptors: Array<NSSortDescriptor>, fetchBatchSize: Int) -> Array<NSManagedObject> {
        return self.retrieveEntries(entityClass, predicate: nil, sortDescriptors: sortDescriptors, fetchBatchSize: fetchBatchSize, fetchLimit: nil)
    }
    
    /**
     Retrieves all entries for an entity in core data.
     
     - param entityClass: a class value for the entity in core data.
     
     - returns: `Array` of `NSManagedObjects`.
     */
    public func retrieveEntries(entityClass: AnyClass) -> Array<NSManagedObject> {
        return self.retrieveEntries(entityClass, predicate: nil, sortDescriptors: nil, fetchBatchSize: nil, fetchLimit: nil)
    }
    
    //MARK: Single
    
    /**
     Retrieves first/top entry for an entity in core data, ordered by sort descriptors and matching the conditions of the predicate.
     
     - param entityClass: a class value for the entity in core data.
     - param predicate: a predicate used to limit the entries returned.
     - param sortDescriptors: an array containing sorting values to be applied to this request.
     
     - returns: `NSManagedObject` instance.
     */
    public func retrieveFirstEntry(entityClass: AnyClass, predicate: NSPredicate?, sortDescriptors: Array<NSSortDescriptor>?) -> NSManagedObject? {
        let managedObjects = self.retrieveEntries(entityClass, predicate: predicate, sortDescriptors: sortDescriptors, fetchBatchSize: nil, fetchLimit: 1)
        
        return managedObjects.first
    }
    
    /**
     Retrieves first/top entry for an entity in core data matching the conditions of the predicate.
     
     - param entityClass: a class value for the entity in core data.
     - param predicate: a predicate used to limit the entries returned.
     
     - returns: `NSManagedObject` instance.
     */
    public func retrieveFirstEntry(entityClass: AnyClass, predicate: NSPredicate) -> NSManagedObject? {
        return self.retrieveFirstEntry(entityClass, predicate: predicate, sortDescriptors: nil)
    }
    
    /**
     Retrieves first/top entry for an entity in core data matching the conditions of the predicate.
     
     - param entityClass: a class value for the entity in core data.
     - param sortDescriptors: an array containing sorting values to be applied to this request.
     
     - returns: `NSManagedObject` instance.
     */
    public func retrieveFirstEntry(entityClass: AnyClass, sortDescriptors: Array<NSSortDescriptor>) -> NSManagedObject? {
        return self.retrieveFirstEntry(entityClass, predicate: nil, sortDescriptors: sortDescriptors)
    }
    
    /**
     Retrieves first/top entry for an entity in core data.
     
     - param entityClass: a class value for the entity in core data.

     - returns: `NSManagedObject` instance.
     */
    public func retrieveFirstEntry(entityClass: AnyClass) -> NSManagedObject? {
        return self.retrieveFirstEntry(entityClass, predicate: nil, sortDescriptors: nil)
    }
}

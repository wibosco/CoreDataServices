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
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter predicate: a predicate used to limit the entries returned.
     - Parameter sortDescriptors: an array containing sorting values to be applied to this request.
     - Parameter fetchBatchSize: limits the number of returned objects in each batch.
     - Parameter fetchLimit : limts the total number of returned objects.
     
     - Returns: `Array` of `NSManagedObjects`.
     */
    @objc(cds_retrieveEntriesForEntityClass:predicate:sortDescriptors:fetchBatchSize:fetchLimit:)
    public func retrieveEntries(entityClass: AnyClass, predicate: NSPredicate?, sortDescriptors: Array<NSSortDescriptor>?, fetchBatchSize: Int, fetchLimit: Int) -> Array<NSManagedObject> {
        let fetchRequest = NSFetchRequest.fetchRequest(entityClass)
        
        if predicate != nil {
            fetchRequest.predicate = predicate
        }
        
        if sortDescriptors != nil && sortDescriptors!.count > 0 {
            fetchRequest.sortDescriptors = sortDescriptors
        }
        
        if fetchBatchSize > 0 {
            fetchRequest.fetchBatchSize = fetchBatchSize
        }
        
        if fetchLimit > 0 {
            fetchRequest.fetchLimit = fetchLimit
        }
        
        var managedObjects: Array<NSManagedObject> = []
        
        do {
            try managedObjects = self.executeFetchRequest(fetchRequest) as! Array<NSManagedObject>
        } catch let error as NSError {
            print("Error attempting to retrieve entries from class \(entityClass), predicate \(predicate), sortDescriptors \(sortDescriptors), fetchBatchSize \(fetchBatchSize), fetchLimit \(fetchLimit), managedObjectContext \(self). Error: \(error.description)")
        }

        return managedObjects
    }
    

    /**
     Retrieves ordered entries for an entity in core data that match the provided predicate's conditions within batches.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter predicate: a predicate used to limit the entries returned.
     - Parameter sortDescriptors: an array containing sorting values to be applied to this request.
     - Parameter fetchBatchSize: limits the number of returned objects in each batch.
     
     - Returns: `Array` of `NSManagedObjects`.
     */
    @objc(cds_retrieveEntriesForEntityClass:predicate:sortDescriptors:fetchBatchSize:)
    public func retrieveEntries(entityClass: AnyClass, predicate: NSPredicate, sortDescriptors: Array<NSSortDescriptor>, fetchBatchSize: Int) -> Array<NSManagedObject> {
        return self.retrieveEntries(entityClass, predicate: predicate, sortDescriptors: sortDescriptors, fetchBatchSize: fetchBatchSize, fetchLimit: 0)
    }
    
    /**
     Retrieves ordered entries for an entity in core data that match the provided predicate's conditions.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter predicate: a predicate used to limit the entries returned.
     - Parameter sortDescriptors: an array containing sorting values to be applied to this request.
     
     - Returns: `Array` of `NSManagedObjects`.
     */
    @objc(cds_retrieveEntriesForEntityClass:predicate:sortDescriptors:)
    public func retrieveEntries(entityClass: AnyClass, predicate: NSPredicate, sortDescriptors: Array<NSSortDescriptor>) -> Array<NSManagedObject> {
        return self.retrieveEntries(entityClass, predicate: predicate, sortDescriptors: sortDescriptors, fetchBatchSize: 0, fetchLimit: 0)
    }
    
    /**
     Retrieves all entries for an entity in core data that match the provided predicate's conditions.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter predicate: a predicate used to limit the entries returned.
     
     - Returns: `Array` of `NSManagedObjects`.
     */
    @objc(cds_retrieveEntriesForEntityClass:predicate:)
    public func retrieveEntries(entityClass: AnyClass, predicate: NSPredicate) -> Array<NSManagedObject> {
        return self.retrieveEntries(entityClass, predicate: predicate, sortDescriptors: nil, fetchBatchSize: 0, fetchLimit: 0)
    }
    
    /**
     Retrieves all entries for an entity in core data within batches.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter fetchBatchSize: limits the number of returned objects in each batch.
     
     - Returns: `Array` of `NSManagedObjects`.
     */
    @objc(cds_retrieveEntriesForEntityClass:fetchBatchSize:)
    public func retrieveEntries(entityClass: AnyClass, fetchBatchSize: Int) -> Array<NSManagedObject> {
        return self.retrieveEntries(entityClass, predicate: nil, sortDescriptors: nil, fetchBatchSize: fetchBatchSize, fetchLimit: 0)
    }
    
    /**
     Retrieves all entries for an entity in core data that match the provided predicate's conditions within batches.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter predicate: a predicate used to limit the entries returned.
     - Parameter fetchBatchSize: limits the number of returned objects in each batch.
     
     - Returns: `Array` of `NSManagedObjects`.
     */
    @objc(cds_retrieveEntriesForEntityClass:predicate:fetchBatchSize:)
    public func retrieveEntries(entityClass: AnyClass, predicate: NSPredicate, fetchBatchSize: Int) -> Array<NSManagedObject> {
        return self.retrieveEntries(entityClass, predicate: predicate, sortDescriptors: nil, fetchBatchSize: fetchBatchSize, fetchLimit: 0)
    }
    
    /**
     Retrieves ordered entries for an entity in core data.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter sortDescriptors: an array containing sorting values to be applied to this request.
     
     - Returns: `Array` of `NSManagedObjects`.
     */
    @objc(cds_retrieveEntriesForEntityClass:sortDescriptors:)
    public func retrieveEntries(entityClass: AnyClass, sortDescriptors: Array<NSSortDescriptor>) -> Array<NSManagedObject> {
        return self.retrieveEntries(entityClass, predicate: nil, sortDescriptors: sortDescriptors, fetchBatchSize: 0, fetchLimit: 0)
    }
    
    /**
     Retrieves ordered entries for an entity in core data within batches.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter sortDescriptors: an array containing sorting values to be applied to this request.
     - Parameter fetchBatchSize: limits the number of returned objects in each batch.
     
     - Returns: `Array` of `NSManagedObjects`.
     */
    @objc(cds_retrieveEntriesForEntityClass:sortDescriptors:fetchBatchSize:)
    public func retrieveEntries(entityClass: AnyClass, sortDescriptors: Array<NSSortDescriptor>, fetchBatchSize: Int) -> Array<NSManagedObject> {
        return self.retrieveEntries(entityClass, predicate: nil, sortDescriptors: sortDescriptors, fetchBatchSize: fetchBatchSize, fetchLimit: 0)
    }
    
    /**
     Retrieves all entries for an entity in core data.
     
     - Parameter entityClass: a class value for the entity in core data.
     
     - Returns: `Array` of `NSManagedObjects`.
     */
    @objc(cds_retrieveEntriesForEntityClass:)
    public func retrieveEntries(entityClass: AnyClass) -> Array<NSManagedObject> {
        return self.retrieveEntries(entityClass, predicate: nil, sortDescriptors: nil, fetchBatchSize: 0, fetchLimit: 0)
    }
    
    //MARK: Single
    
    /**
     Retrieves first/top entry for an entity in core data, ordered by sort descriptors and matching the conditions of the predicate.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter predicate: a predicate used to limit the entries returned.
     - Parameter sortDescriptors: an array containing sorting values to be applied to this request.
     
     - Returns: `NSManagedObject` instance.
     */
    @objc(cds_retrieveFirstEntryForEntityClass:predicate:sortDescriptors:)
    public func retrieveFirstEntry(entityClass: AnyClass, predicate: NSPredicate?, sortDescriptors: Array<NSSortDescriptor>?) -> NSManagedObject? {
        let managedObjects = self.retrieveEntries(entityClass, predicate: predicate, sortDescriptors: sortDescriptors, fetchBatchSize: 0, fetchLimit: 1)
        
        return managedObjects.first
    }
    
    /**
     Retrieves first/top entry for an entity in core data matching the conditions of the predicate.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter predicate: a predicate used to limit the entries returned.
     
     - Returns: `NSManagedObject` instance.
     */
    @objc(cds_retrieveFirstEntryForEntityClass:predicate:)
    public func retrieveFirstEntry(entityClass: AnyClass, predicate: NSPredicate) -> NSManagedObject? {
        return self.retrieveFirstEntry(entityClass, predicate: predicate, sortDescriptors: nil)
    }
    
    /**
     Retrieves first/top entry for an entity in core data matching the conditions of the predicate.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter sortDescriptors: an array containing sorting values to be applied to this request.
     
     - Returns: `NSManagedObject` instance.
     */
    @objc(cds_retrieveFirstEntryForEntityClass:sortDescriptors:)
    public func retrieveFirstEntry(entityClass: AnyClass, sortDescriptors: Array<NSSortDescriptor>) -> NSManagedObject? {
        return self.retrieveFirstEntry(entityClass, predicate: nil, sortDescriptors: sortDescriptors)
    }
    
    /**
     Retrieves first/top entry for an entity in core data.
     
     - Parameter entityClass: a class value for the entity in core data.

     - Returns: `NSManagedObject` instance.
     */
    @objc(cds_retrieveFirstEntryForEntityClass:)
    public func retrieveFirstEntry(entityClass: AnyClass) -> NSManagedObject? {
        return self.retrieveFirstEntry(entityClass, predicate: nil, sortDescriptors: nil)
    }
}

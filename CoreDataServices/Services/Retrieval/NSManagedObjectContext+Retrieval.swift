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
    
    //MARK: - Multiple
    
    /**
     Retrieves top ordered entries for an entity in core data that match the provided predicate's conditions within batches.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter predicate: a predicate used to limit the entries returned.
     - Parameter sortDescriptors: an array containing sorting values to be applied to this request.
     - Parameter fetchBatchSize: limits the number of returned objects in each batch.
     - Parameter fetchLimit : limts the total number of returned objects.
     
     - Returns: `Array` of `NSManagedObjects`.
     */
    public func retrieveEntries<T: NSManagedObject>(entityClass: T.Type, predicate: NSPredicate?, sortDescriptors: Array<NSSortDescriptor>?, fetchBatchSize: Int, fetchLimit: Int) -> Array<T> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityClass: entityClass)
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        
        if let sortDescriptors = sortDescriptors {
            fetchRequest.sortDescriptors = sortDescriptors
        }
        
        if fetchBatchSize > 0 {
            fetchRequest.fetchBatchSize = fetchBatchSize
        }
        
        if fetchLimit > 0 {
            fetchRequest.fetchLimit = fetchLimit
        }
        
        do {
            let managedObjects = try self.fetch(fetchRequest) as! Array<T>
            
            return managedObjects
        } catch {
            print("Error attempting to retrieve entries from class \(entityClass), predicate \(String(describing: predicate)), sortDescriptors \(describing: sortDescriptors), fetchBatchSize \(fetchBatchSize), fetchLimit \(fetchLimit), managedObjectContext \(self). Error: \(error)")
            
            return Array<T>()
        }
    }
    
    
    /**
     Retrieves ordered entries for an entity in core data that match the provided predicate's conditions within batches.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter predicate: a predicate used to limit the entries returned.
     - Parameter sortDescriptors: an array containing sorting values to be applied to this request.
     - Parameter fetchBatchSize: limits the number of returned objects in each batch.
     
     - Returns: `Array` of `NSManagedObjects`.
     */
    public func retrieveEntries<T: NSManagedObject>(entityClass: T.Type, predicate: NSPredicate, sortDescriptors: Array<NSSortDescriptor>, fetchBatchSize: Int) -> Array<T> {
        return self.retrieveEntries(entityClass: entityClass, predicate: predicate, sortDescriptors: sortDescriptors, fetchBatchSize: fetchBatchSize, fetchLimit: 0)
    }
    
    /**
     Retrieves ordered entries for an entity in core data that match the provided predicate's conditions.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter predicate: a predicate used to limit the entries returned.
     - Parameter sortDescriptors: an array containing sorting values to be applied to this request.
     
     - Returns: `Array` of `NSManagedObjects`.
     */
    public func retrieveEntries<T: NSManagedObject>(entityClass: T.Type, predicate: NSPredicate, sortDescriptors: Array<NSSortDescriptor>) -> Array<T> {
        return self.retrieveEntries(entityClass: entityClass, predicate: predicate, sortDescriptors: sortDescriptors, fetchBatchSize: 0, fetchLimit: 0)
    }
    
    /**
     Retrieves all entries for an entity in core data that match the provided predicate's conditions.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter predicate: a predicate used to limit the entries returned.
     
     - Returns: `Array` of `NSManagedObjects`.
     */
    public func retrieveEntries<T: NSManagedObject>(entityClass: T.Type, predicate: NSPredicate) -> Array<T> {
        return self.retrieveEntries(entityClass: entityClass, predicate: predicate, sortDescriptors: nil, fetchBatchSize: 0, fetchLimit: 0)
    }
    
    /**
     Retrieves all entries for an entity in core data within batches.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter fetchBatchSize: limits the number of returned objects in each batch.
     
     - Returns: `Array` of `NSManagedObjects`.
     */
    public func retrieveEntries<T: NSManagedObject>(entityClass: T.Type, fetchBatchSize: Int) -> Array<T> {
        return self.retrieveEntries(entityClass: entityClass, predicate: nil, sortDescriptors: nil, fetchBatchSize: fetchBatchSize, fetchLimit: 0)
    }
    
    /**
     Retrieves all entries for an entity in core data that match the provided predicate's conditions within batches.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter predicate: a predicate used to limit the entries returned.
     - Parameter fetchBatchSize: limits the number of returned objects in each batch.
     
     - Returns: `Array` of `NSManagedObjects`.
     */
    public func retrieveEntries<T: NSManagedObject>(entityClass: T.Type, predicate: NSPredicate, fetchBatchSize: Int) -> Array<T> {
        return self.retrieveEntries(entityClass: entityClass, predicate: predicate, sortDescriptors: nil, fetchBatchSize: fetchBatchSize, fetchLimit: 0)
    }
    
    /**
     Retrieves ordered entries for an entity in core data.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter sortDescriptors: an array containing sorting values to be applied to this request.
     
     - Returns: `Array` of `NSManagedObjects`.
     */
    public func retrieveEntries<T: NSManagedObject>(entityClass: T.Type, sortDescriptors: Array<NSSortDescriptor>) -> Array<T> {
        return self.retrieveEntries(entityClass: entityClass, predicate: nil, sortDescriptors: sortDescriptors, fetchBatchSize: 0, fetchLimit: 0)
    }
    
    /**
     Retrieves ordered entries for an entity in core data within batches.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter sortDescriptors: an array containing sorting values to be applied to this request.
     - Parameter fetchBatchSize: limits the number of returned objects in each batch.
     
     - Returns: `Array` of `NSManagedObjects`.
     */
    public func retrieveEntries<T: NSManagedObject>(entityClass: T.Type, sortDescriptors: Array<NSSortDescriptor>, fetchBatchSize: Int) -> Array<T> {
        return self.retrieveEntries(entityClass: entityClass, predicate: nil, sortDescriptors: sortDescriptors, fetchBatchSize: fetchBatchSize, fetchLimit: 0)
    }
    
    /**
     Retrieves all entries for an entity in core data.
     
     - Parameter entityClass: a class value for the entity in core data.
     
     - Returns: `Array` of `NSManagedObjects`.
     */
    public func retrieveEntries<T: NSManagedObject>(entityClass: T.Type) -> Array<T> {
        return self.retrieveEntries(entityClass: entityClass, predicate: nil, sortDescriptors: nil, fetchBatchSize: 0, fetchLimit: 0)
    }
    
    //MARK: - Single
    
    /**
     Retrieves first/top entry for an entity in core data, ordered by sort descriptors and matching the conditions of the predicate.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter predicate: a predicate used to limit the entries returned.
     - Parameter sortDescriptors: an array containing sorting values to be applied to this request.
     
     - Returns: `NSManagedObject` instance.
     */
    public func retrieveFirstEntry<T: NSManagedObject>(entityClass: T.Type, predicate: NSPredicate?, sortDescriptors: Array<NSSortDescriptor>?) -> T? {
        let managedObjects = self.retrieveEntries(entityClass: entityClass, predicate: predicate, sortDescriptors: sortDescriptors, fetchBatchSize: 0, fetchLimit: 1)
        
        return managedObjects.first
    }
    
    /**
     Retrieves first/top entry for an entity in core data matching the conditions of the predicate.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter predicate: a predicate used to limit the entries returned.
     
     - Returns: `NSManagedObject` instance.
     */
    public func retrieveFirstEntry<T: NSManagedObject>(entityClass: T.Type, predicate: NSPredicate) -> T? {
        return self.retrieveFirstEntry(entityClass: entityClass, predicate: predicate, sortDescriptors: nil)
    }
    
    /**
     Retrieves first/top entry for an entity in core data matching the conditions of the predicate.
     
     - Parameter entityClass: a class value for the entity in core data.
     - Parameter sortDescriptors: an array containing sorting values to be applied to this request.
     
     - Returns: `NSManagedObject` instance.
     */
    public func retrieveFirstEntry<T: NSManagedObject>(entityClass: T.Type, sortDescriptors: Array<NSSortDescriptor>) -> T? {
        return self.retrieveFirstEntry(entityClass: entityClass, predicate: nil, sortDescriptors: sortDescriptors)
    }
    
    /**
     Retrieves first/top entry for an entity in core data.
     
     - Parameter entityClass: a class value for the entity in core data.
     
     - Returns: `NSManagedObject` instance.
     */
    public func retrieveFirstEntry<T: NSManagedObject>(entityClass: T.Type) -> T? {
        return self.retrieveFirstEntry(entityClass: entityClass, predicate: nil, sortDescriptors: nil)
    }
}

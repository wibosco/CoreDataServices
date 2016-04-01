//
//  NSFetchRequest+FetchRequest.swift
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
public extension NSFetchRequest {
    
    //MARK: Class
    
    /**
     Convenience init method to allow for retreive of a NSFetchRequest instance given a core data entity class.
     
     @param entityClass - class value for the entity in core data.
     
     @return `NSFetchRequest` instance for the entityClass passed in.
     */
    public class func fetchRequest(entityClass: AnyClass) -> NSFetchRequest? {
        var fetchRequest: NSFetchRequest?
        
        if let entityName = String(entityClass).componentsSeparatedByString(".").last {
            fetchRequest = NSFetchRequest(entityName: entityName)
        }
        
        return fetchRequest
    }
}
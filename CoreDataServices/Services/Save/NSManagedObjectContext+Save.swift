//
//  NSManagedObjectContext+Save.swift
//  CoreDataServices
//
//  Created by William Boles on 02/07/2017.
//  Copyright © 2017 Boles. All rights reserved.
//

import Foundation
import CoreData

/**
 An extension that extends `NSManagedObjectContext` to provide convenience functions related to saving.
 */
public extension NSManagedObjectContext {

    /**
     Saves any pending changes in current context, skips save if there are no changes. If current context is of type `privateQueueConcurrencyType` then the save operation is propagated up the stack until it reaches a context with `mainQueueConcurrencyType`.
     */
    public func saveAndForcePushChangesIfNeeded() {
        if hasChanges {
            do {
                try save()
                
                //Force context to process pending changes as cascading deletes may not be immediately applied by coredata.
                processPendingChanges()
                
                if concurrencyType == .privateQueueConcurrencyType {
                    parent?.saveAndForcePushChangesIfNeeded()
                }
            } catch {
                print("Couldn't save context: \(error)")
            }
        }
    }
}

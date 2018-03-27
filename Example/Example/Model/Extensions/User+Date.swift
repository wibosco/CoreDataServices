//
//  User+Date.swift
//  Example
//
//  Created by William Boles on 20/12/2017.
//  Copyright © 2017 Boles. All rights reserved.
//

import CoreData

extension User {
    
    // MARK: - Insert
    
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        
        dateAdded = Date()
    }
    
    // MARK: - Age
    
    var age: Int? {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.year], from: dateOfBirth! as Date, to: Date())
        
        return components.year
    }
}

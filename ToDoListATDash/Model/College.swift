//
//  College.swift
//  ToDoListATDash
//
//  Created by Nicholas Salzman on 4/25/16.
//  Copyright © 2016 Nicholas Salzman. All rights reserved.
//

import RealmSwift

class College: Object {
    
    dynamic var pk = 0 //primary key
    dynamic var model: CollegeControl!
    dynamic var fields: CollegeFields!
    dynamic var isFavorite = false
    
    override static func primaryKey() -> String? {
        return "pk"
    }
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}

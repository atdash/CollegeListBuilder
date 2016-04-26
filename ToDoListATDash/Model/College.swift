//
//  College.swift
//  ToDoListATDash
//
//  Created by Nicholas Salzman on 4/25/16.
//  Copyright © 2016 Nicholas Salzman. All rights reserved.
//

import RealmSwift

class College: Object {
    
    dynamic var admitster_id = 0
    dynamic var model = ""
    dynamic var isFavorite = false
    dynamic var name = ""
    dynamic var examsRequired = ""

    
    override static func primaryKey() -> String? {
        return "admitster_id"
    }
        
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}

//
//  FieldExamsRequired.swift
//  ToDoListATDash
//
//  Created by Nicholas Salzman on 4/25/16.
//  Copyright © 2016 Nicholas Salzman. All rights reserved.
//

import RealmSwift

class FieldExamsRequired: Object {
    dynamic var examRequired = ""

    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}

//
//  Person.swift
//  ToDoListATDash
//
//  Created by Nicholas Salzman on 4/26/16.
//  Copyright © 2016 Nicholas Salzman. All rights reserved.
//

import Foundation
import RealmSwift

class Person: Object {
    
    dynamic var name = ""
    
    let favColleges = List<College>()
    let similarColleges = List<College>()
    
    dynamic var SAT_Math = 0
    dynamic var SAT_Reading = 0
    dynamic var SAT_Writing = 0
    dynamic var Combined_SAT = 0

    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}

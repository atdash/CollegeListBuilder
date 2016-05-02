//
//  CollegeList.swift
//  ToDoListATDash
//
//  Created by Nicholas Salzman on 4/25/16.
//  Copyright © 2016 Nicholas Salzman. All rights reserved.
//

import RealmSwift

class CollegeList: Object {
    
    dynamic var name = ""
    dynamic var createdAt = NSDate()
    dynamic var owner: Person?
    let collegeList = List<College>()
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}

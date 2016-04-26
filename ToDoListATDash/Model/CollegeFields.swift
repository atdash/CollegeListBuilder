//
//  CollegeFields.swift
//  ToDoListATDash
//
//  Created by Nicholas Salzman on 4/25/16.
//  Copyright © 2016 Nicholas Salzman. All rights reserved.
//

import RealmSwift

class CollegeFields: Object {
    dynamic var admitster_id = 0
    dynamic var name = ""
    dynamic var examsRequired: FieldExamsRequired!
    /*
    dynamic var sat_math_estimated_median = 0
    dynamic var sat_math_high = 0
    dynamic var sat_reading_low = 0
    dynamic var sat_reading_high = 0
    dynamic var sat_reading_estimated_median = 0
    dynamic var sat_math_low = 0
    dynamic var sat_writing_low = 0
    dynamic var sat_writing_estimated_median = 0
    dynamic var sat_writing_high = 0
    */

    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}

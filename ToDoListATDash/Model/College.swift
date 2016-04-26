//
//  College.swift
//  ToDoListATDash
//
//  Created by Nicholas Salzman on 4/25/16.
//  Copyright © 2016 Nicholas Salzman. All rights reserved.
//

import RealmSwift

class College: Object {
    
    dynamic var isFavorite = false

    dynamic var control = ""
    dynamic var model = ""
    dynamic var admitster_id = 0
    dynamic var name = ""
    dynamic var examsRequired = ""
    dynamic var base_cost = 0
    dynamic var city = ""
    dynamic var census_region = ""
    dynamic var main_web = ""
    dynamic var religious_affiliation = ""
    dynamic var state = ""
    dynamic var cmschools_id = 0
    dynamic var zip_code = ""
    dynamic var metropolitan_status = ""
    dynamic var tel_num = ""
    dynamic var in_state_tuition_cost = 0
    dynamic var collegeboard_id = 0
    dynamic var student_faculty_ratio = 0
    dynamic var unit_id = ""
    dynamic var street_address = ""
    dynamic var has_greek_life = true
    dynamic var admission_yield = 0
    dynamic var perc_unknown = 0.0
    dynamic var act_composite_estimated_median = 0
    dynamic var women_only = true
    dynamic var out_state_tuition_cost = 0
    dynamic var perc_hawaiian = 0.0
    dynamic var perc_black = 0.0
    dynamic var perc_white = 0.0
    dynamic var undergrad_enrollment = 0
    dynamic var act_composite_low = 0
    dynamic var perc_native = 0.0
    dynamic var perc_hispanic = 0.0
    dynamic var perc_with_fin_aid = 0
    dynamic var act_composite_high = 0
    dynamic var early_decision_available = true
    dynamic var perc_asianpacific = 0.0
    dynamic var admission_rate = 0
    dynamic var perc_mixed = 0.0
    dynamic var perc_aliens = 0.0
    dynamic var enrollment = 0
    dynamic var men_only = true
    dynamic var early_action_available = true
    dynamic var sat_math_estimated_median = 0
    dynamic var sat_math_high = 0
    dynamic var graduation_rate = 0
    dynamic var sat_reading_low = 0
    dynamic var sat_reading_high = 0
    dynamic var sat_reading_estimated_median = 0
    dynamic var sat_math_low = 0
    dynamic var sat_writing_low = 0
    dynamic var sat_writing_estimated_median = 0
    dynamic var sat_writing_high = 0
    dynamic var liberal_arts = true
    dynamic var early_decision_admission_rate = 0
    dynamic var early_action_is_restrictive = true
    dynamic var early_action_admission_rate = 0

    override static func primaryKey() -> String? {
        return "admitster_id"
    }
        
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}

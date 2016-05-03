//
//  College.swift
//  ToDoListATDash
//
//  Created by Nicholas Salzman on 4/25/16.
//  Copyright © 2016 Nicholas Salzman. All rights reserved.
//

import RealmSwift

class College: Object {
    
    /*
    *   isInList filters for what colleges to display
    *   isFavorite is toggled by user
    *   Favorite colleges are sent to Admitster to generate similar colleges
    *   Similar colleges are added as isInList, but not favorites
    */
    dynamic var isFavorite = false
    dynamic var isInList = false
    dynamic var admit_likelihood: Float = 0.0

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
    dynamic var has_greek_life = false
    dynamic var admission_yield = 0
    dynamic var perc_unknown: Float = 0.0
    dynamic var act_composite_estimated_median = 0
    dynamic var women_only = false
    dynamic var out_state_tuition_cost = 0
    dynamic var perc_hawaiian: Float = 0.0
    dynamic var perc_black: Float = 0.0
    dynamic var perc_white: Float = 0.0
    dynamic var undergrad_enrollment = 0
    dynamic var act_composite_low = 0
    dynamic var perc_native: Float = 0.0
    dynamic var perc_hispanic: Float = 0.0
    dynamic var perc_with_fin_aid: Float = 0.0
    dynamic var act_composite_high = 0
    dynamic var early_decision_available = false
    dynamic var perc_asianpacific: Float = 0.0
    dynamic var admission_rate = 0
    dynamic var perc_mixed: Float = 0.0
    dynamic var perc_aliens: Float = 0.0
    dynamic var enrollment = 0
    dynamic var men_only = false
    dynamic var early_action_available = false
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
    dynamic var liberal_arts = false
    dynamic var early_decision_admission_rate = 0
    dynamic var early_action_is_restrictive = false
    dynamic var early_action_admission_rate = 0

    override static func primaryKey() -> String? {
        return "admitster_id"
    }
        
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}

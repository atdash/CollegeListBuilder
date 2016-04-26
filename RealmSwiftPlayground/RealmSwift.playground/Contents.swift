//: Please build the scheme 'RealmSwiftPlayground' first
import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

import Foundation
import RealmSwift

print(Realm.Configuration.defaultConfiguration.path!)


class Birthday: Object {
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var birthday = NSDate(timeIntervalSince1970: 1)
    
}


class College: Object {
    dynamic var pk = 0 //primary key
    dynamic var model: CollegeControl!
    dynamic var fields: Fields!
    
    override static func primaryKey() -> String? {
        return "pk"
    }
}


class CollegeControl: Object {
    dynamic var collegeControl = ""
}


// classes required for a single college
class ExamsRequired: Object {
    dynamic var examRequired = ""
}


class Fields: Object {
    dynamic var admitster_id = 0
    dynamic var name = ""
    dynamic var examsRequired: ExamsRequired!
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
}


func CreateColleges() {
    let college = College()
    college.pk = college.fields.admitster_id
    college.model.collegeControl = "Private"
    college.fields.admitster_id = 12345
    college.fields.name = "Harvard"
    college.fields.examsRequired.examRequired = "ALL"
    
    let realm = try! Realm()
    
    try! realm.write {
        realm.add(college)
    }
}


func AddCollege() {
    
}

//
//  College_enums.swift
//  CollegeListBuilder
//
//  Created by Nicholas Salzman on 4/18/16.
//  Copyright © 2016 Realm Inc. All rights reserved.
//

/*
class College: Object {
    dynamic var pk = 0 //primary key
    dynamic var model: CollegeControl!
    dynamic var fields: Fields!
}


class CollegeControl: Object {
    dynamic var collegeControl = ""
}


// classes required for a single college
class ExamsRequired: Object {
    dynamic var examRequired = ""
}


class Fields: Object {
    dynamic var examsRequired: ExamsRequired!
    dynamic var admitster_id = 0
    dynamic var name = ""
    dynamic var sat_math_estimated_median = 0
    dynamic var sat_math_high = 0
    dynamic var sat_reading_low = 0
    dynamic var sat_reading_high = 0
    dynamic var sat_reading_estimated_median = 0
    dynamic var sat_math_low = 0
    dynamic var sat_writing_low = 0
    dynamic var sat_writing_estimated_median = 0
    dynamic var sat_writing_high = 0
    
    override static func primanryKey() -> String {
        return admitster_id
    }
}


    enum ExamsRequired: String {
        case BOTH = "Both"
        case ANY  = "Any"
        case ACT  = "ACT"
        case SAT  = "SAT"
    }
    
    class ExamsRequiredHelper: Object {
        dynamic var id = 0
        private dynamic var examsRequired = ExamsRequired.BOTH.rawValue
        var examsRequiredEnum: ExamsRequired {
            get { return ExamsRequired(rawValue: examsRequired)!}
            set { examsRequired = newValue.rawValue}
        }
    }

    
    enum CollegeControl: String {
        case PUBLIC      = "Public"
        case PRIVATE     = "Private"
        case PROPRIETARY = "Proprietary"
    }
    
    class CollegeControlHelper: Object {
        dynamic var id = 1
        private dynamic var collegeControl = CollegeControl.PRIVATE.rawValue
        var collegeControlEnum: CollegeControl {
            get { return CollegeControl(rawValue: collegeControl)!}
            set { collegeControl = newValue.rawValue}
        }
    }


    enum CensusRegion: String {
        case WEST      = "West"
        case MIDWEST   = "Midwest"
        case SOUTH     = "South"
        case NORTHEAST = "Northeast"
        case MIDATLANTIC = "Midatlantic"
    }
    
    
    enum MetropolitanStatus: String {
        case URBAN    = "City"
        case SUBURBAN = "Suburb"
        case RURAL    = "Rural"
    }
    
    
    enum ReligiousAffiliation: String {
        case SEVENTH_DAY_ADVENTIST               = "Seventh Day Adventist"
        case ADVENT_CHRISTIAN                    = "Advent Christian Church"
        case AFRICAN_METHODIST                   = "African Methodist Episcopal Church"
        case AFRICAN_METHODIST_ZION              = "African Methodist Episcopal Zion Church"
        case AMERICAN_BAPTIST_USA                = "American Baptist Churches In The Usa"
        case NORTH_AMERICAN_BAPTIST              = "North American Baptist General Convention"
        case AMERICAN_LUTHERAN                   = "American Lutheran Church"
        case ASSEMBLIES_OF_GOD                   = "Assemblies Of God"
        case BAPTIST                             = "Baptist"
        case BAPTIST_GENERAL_CONFERENCE          = "Baptist General Conference"
        case BRETHREN_CHURCH                     = "Brethren Church"
        case BRETHREN_IN_CHRIST_CHURCH           = "Brethren In Christ Church"
        case CHRISTIAN                           = "Christian Church"
        case LATTER_DAY_SAINTS                   = "Church Of Jesus Christ Of Latter Day Saints"
        case METHODIST_EPISCOPAL                 = "Christian Methodist Episcopal Church"
        case CHRISTIAN_MISSIONARY_ALLIANCE       = "Christian And Missionary Alliance"
        case CHRISTIAN_REFORMED                  = "Christian Reformed Church"
        case CHURCH_OF_THE_BRETHREN              = "Church Of The Brethren"
        case CHURCH_OF_CHRIST                    = "Church Of Christ"
        case CHURCH_OF_GOD                       = "Church Of God"
        case CHURCH_OF_NAZARENE                  = "Church Of The Nazarene"
        case CUMBERLAND_PRESBYTERIAN             = "Cumberland Presbyterian Church"
        case DISCIPLES_OF_CHRIST                 = "Christian Church (Disciples Of Christ)"
        case EPISCOPAL                           = "Episcopal Church"
        case EVANGELICAL_CONGREGATIONAL          = "Evangelical Congregational Church"
        case EVANGELICAL_COVENANT_AMERICA        = "Evangelical Covenant Church Of America"
        case EVENGELICAL_FREE_AMERICA            = "Evangelical Free Church Of America"
        case EVENGELICAL_LUTHERAN_AMERICA        = "Evangelical Lutheran Church In America"
        case EVANGELICAL_LUTHERAN_SYNOD          = "Evangelical Lutheran Synod"
        case FREE_METHODIST_NORTH_AMERICA        = "Free Methodist Church Of North America"
        case OTHER                               = "other"
        case FREE_WILL_BAPTISTS                  = "Free Will Baptists"
        case REGULAR_BAPTIST                     = "General Association Of Regular Baptist Churches"
        case GENERAL_CONFERENCE_MENNONITE        = "General Conference, Mennonite Church"
        case GREEK_ORTHODOX_AMERICA              = "Greek Orthodox Archdiocese Of North And South America"
        case INTERDENOMINATIONAL                 = "Interdenominational"
        case JEWISH                              = "Jewish"
        case LUTHERAN_AMERICA                    = "Lutheran Church In America"
        case LUTHERAN_MISSOURI                   = "Lutheran Church Missouri Synod"
        case MENNONITE_BRETHREN                  = "Mennonite Brethren Church"
        case MENNONITE                           = "Mennonite Church"
        case MISSIONARY_CHURCH                   = "Missionary Church"
        case MORAVIAN_AMERICA                    = "Moravian Church In America"
        case NONDENOMINATIONAL                   = "Nondemoninational"
        case PENTECOSTAL_HOLINESS                = "Pentecostal Holiness Church"
        case PRESBYTERIAN_CHURCH_USA             = "Presbyterian Church (Usa)"
        case QUAKER                              = "Society Of Friends (Quaker)"
        case REORGANIZED_LATTER_DAY_SAINTS       = "Reorganized Church Of Jesus Christ Of Latter Day Saints"
        case REFORMED_AMERICA                    = "Reformed Church In America"
        case REFORMED_EPISCOPAL                  = "Reformed Episcopal Church"
        case REFORMED_PRESBYTERIAN_NORTH_AMERICA = "Reformed Presbyterian Church Of North America"
        case ROMAN_CATHOLIC                      = "Roman Catholic Church"
        case SOUTHERN_BAPTIST                    = "Southern Baptist Convention"
        case UKRAINIAN_CATHOLIC                  = "Ukranian Catholic Church"
        case UNITARIAN_UNIVERSALIST              = "Unitarian Universalist Association"
        case UNITED_BRETHREN                     = "United Brethren In Christ"
        case UNITED_CHRIST                       = "United Church Of Christ"
        case UNITED_METHODIST                    = "United Methodist Church"
        case WESLEYAN                            = "Wesleyan Church"
        case WISCONSIN_EVANGELICAL_LUTHERAN      = "Wisconsin Evangelical Lutheran Synod"
    }
    
    
    enum DegreeLevel: Int {
        case POST_SECONDARY         = 1
        case ASSOCIATE              = 2
        case BACHELOR               = 3
        case POST_BACHELOR          = 4
        case MASTER                 = 5
        case POST_MASTER            = 6
        case DOCTORATE              = 7
        case DOCTORATE_PROFESSIONAL = 8
    }
    
    
    
    // Specify properties to ignore (Realm won't persist these)
    
    //  override static func ignoredProperties() -> [String] {
    //    return []
    //  }
//}



class College: Object {
    dynamic var pk = 0
    dynamic var model = ""
    dynamic var fields: Fields!
    
}

class Fields: Object {
    var control: CollegeControlHelper!
    var exams_required: ExamsRequiredHelper!
    
    
/*
    dynamic var base_cost = 0
    dynamic var city = ""
    dynamic var census_region = ""
    dynamic var main_web = ""
    dynamic var religious_affiliation = ""
    dynamic var state = ""
    dynamic var cmschools_id = 0
    dynamic var admitster_id = 0
    dynamic var zip_code = ""
    dynamic var metropolitan_status = ""
    dynamic var tel_num = ""
    dynamic var in_state_tuition_cost = 0
    dynamic var name = ""
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
*/
}


//var CollegeExams = ExamsRequiredHelper()
//CollegeExams.examsRequiredEnum = .ANY
//print("From ExamsRequiredHelper \(CollegeExams.examsRequiredEnum)")

var CControl = CollegeControlHelper()
CControl.collegeControlEnum


var colleges = College()
colleges.pk
// print("From class College() \(colleges.fields?.exams_required.examsRequiredEnum)")
//colleges.fields.control





class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

var namedShapes = NamedShape(name: "nice shape")
namedShapes.name
*/

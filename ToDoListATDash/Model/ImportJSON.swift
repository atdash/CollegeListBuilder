//
//  ImportJSON.swift
//  ToDoListATDash
//
//  Created by Nicholas Salzman on 4/26/16.
//  Copyright © 2016 Nicholas Salzman. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

//let URLString = "http://localhost/colleges-two.json"
let URLString = "http://localhost/colleges-20150803-0441.json"


func PutThatInTheRealm (withUrCollege: CollegeJSON) {

    let realm = try! Realm()
    
    do {
        try! realm.write {
            
            let newCollege = College()
            
//            newCollege.model = withUrCollege.model!
            if let Urmodel = withUrCollege.model {
                newCollege.model = Urmodel}

//            newCollege.admitster_id = withUrCollege.admitster_id!
            if let urAdmitster_id = withUrCollege.admitster_id {
                newCollege.admitster_id = urAdmitster_id}
            
//            newCollege.control = withUrCollege.control!
            if let urControl = withUrCollege.control {
                newCollege.control = urControl}

//            newCollege.name = withUrCollege.name!
            if let urName = withUrCollege.name {
                newCollege.name = urName}
            
//            newCollege.examsRequired = withUrCollege.examsRequired!
            if let urExamsRequired = withUrCollege.examsRequired {
                newCollege.examsRequired = urExamsRequired}

//            newCollege.base_cost = withUrCollege.base_cost!
            if let urBase_cost = withUrCollege.base_cost {
                newCollege.base_cost = urBase_cost}

//            newCollege.city = withUrCollege.city!
            if let urCity = withUrCollege.city {
                newCollege.city = urCity}

//            newCollege.census_region = withUrCollege.census_region!
            if let urCensus_region = withUrCollege.census_region {
                newCollege.census_region = urCensus_region}

//            newCollege.main_web = withUrCollege.main_web!
            if let urMain_web = withUrCollege.main_web {
                newCollege.main_web = urMain_web}

//            newCollege.religious_affiliation = withUrCollege.religious_affiliation!
            if let urReligious_affiliation =  withUrCollege.religious_affiliation {
                newCollege.religious_affiliation = urReligious_affiliation}

//            newCollege.state = withUrCollege.state!
            if let urState = withUrCollege.state {
                newCollege.state = urState}

//            newCollege.cmschools_id = withUrCollege.cmschools_id!
            if let urCmschools_id = withUrCollege.cmschools_id {
                newCollege.cmschools_id = urCmschools_id}

//            newCollege.zip_code = withUrCollege.zip_code!
            if let urZip_code = withUrCollege.zip_code {
                newCollege.zip_code = urZip_code}

//            newCollege.metropolitan_status = withUrCollege.metropolitan_status!
            if let urMetropolitan_status = withUrCollege.metropolitan_status {
                newCollege.metropolitan_status = urMetropolitan_status}

//            newCollege.tel_num = withUrCollege.tel_num!
            if let urTel_num = withUrCollege.tel_num {
                newCollege.tel_num = urTel_num}

//            newCollege.in_state_tuition_cost = withUrCollege.in_state_tuition_cost!
            if let urIn_state_tuition_cost = withUrCollege.in_state_tuition_cost {
                newCollege.in_state_tuition_cost = urIn_state_tuition_cost}

//            newCollege.collegeboard_id = withUrCollege.collegeboard_id!
            if let urCollegeboard_id = withUrCollege.collegeboard_id {
                newCollege.collegeboard_id = urCollegeboard_id}

//            newCollege.student_faculty_ratio = withUrCollege.student_faculty_ratio!
            if let urStudent_faculty_ratio = withUrCollege.student_faculty_ratio {
                newCollege.student_faculty_ratio = urStudent_faculty_ratio}

//            newCollege.unit_id = withUrCollege.unit_id!
            if let urUnit_id = withUrCollege.unit_id {
                newCollege.unit_id = urUnit_id}

//            newCollege.street_address = withUrCollege.street_address!
            if let urStreet_address = withUrCollege.street_address {
                newCollege.street_address = urStreet_address}

                        //    var has_greek_life: Bool
            if let urHas_greek_life = withUrCollege.has_greek_life {
                newCollege.has_greek_life = urHas_greek_life}
            
//            newCollege.admission_yield = withUrCollege.admission_yield!
            if let urAdmissions_yield = withUrCollege.admission_yield {newCollege.admission_yield = urAdmissions_yield}

//            newCollege.perc_unknown = withUrCollege.perc_unknown!
            if let urPerc_unkown = withUrCollege.perc_unknown {newCollege.perc_unknown = urPerc_unkown}

//            newCollege.act_composite_estimated_median = withUrCollege.act_composite_estimated_median!
            if let urAct_composite_estimated_median = withUrCollege.act_composite_estimated_median {newCollege.act_composite_estimated_median = urAct_composite_estimated_median}

                        //    var women_only: Bool
            if let urWomen_only = withUrCollege.women_only {
                newCollege.women_only = urWomen_only}
            
//            newCollege.out_state_tuition_cost = withUrCollege.out_state_tuition_cost!
            if let urOut_state_tuition_cost = withUrCollege.out_state_tuition_cost {newCollege.out_state_tuition_cost = urOut_state_tuition_cost}

//            newCollege.perc_hawaiian = withUrCollege.perc_hawaiian!
            if let urPerc_hawaiian = withUrCollege.perc_hawaiian {
                newCollege.perc_hawaiian = urPerc_hawaiian}

//            newCollege.perc_black = withUrCollege.perc_black!
            if let urPerc_black = withUrCollege.perc_black {
                newCollege.perc_black = urPerc_black}

//            newCollege.perc_white = withUrCollege.perc_white!
            if let urPerc_white = withUrCollege.perc_white {
                newCollege.perc_white = urPerc_white}

//            newCollege.undergrad_enrollment = withUrCollege.undergrad_enrollment!
            if let urUndergrad_enrollment = withUrCollege.undergrad_enrollment {
                newCollege.undergrad_enrollment = urUndergrad_enrollment}

//            newCollege.act_composite_low = withUrCollege.act_composite_low!
            if let urAct_composite_low = withUrCollege.act_composite_low {
                newCollege.act_composite_low = urAct_composite_low}

//            newCollege.perc_native = withUrCollege.perc_native!
            if let urPerc_native = withUrCollege.perc_native {
                newCollege.perc_native = urPerc_native}

//            newCollege.perc_hispanic = withUrCollege.perc_hispanic!
            if let urPerc_hispanic = withUrCollege.perc_hispanic {
                newCollege.perc_hispanic = urPerc_hispanic}

//            newCollege.perc_with_fin_aid = withUrCollege.perc_with_fin_aid!
            if let urPerc_with_fin_aid = withUrCollege.perc_with_fin_aid {
                newCollege.perc_with_fin_aid = urPerc_with_fin_aid}

//            newCollege.act_composite_high = withUrCollege.act_composite_high!
            if let urAct_composite_high = withUrCollege.act_composite_high {
                newCollege.act_composite_high = urAct_composite_high}

                        //    var early_decision_available: Bool
            if let urErly_decision_available = withUrCollege.early_decision_available {
                newCollege.early_decision_available = urErly_decision_available}
            
//            newCollege.perc_asianpacific = withUrCollege.perc_asianpacific!
            if let urPerc_asianpacific = withUrCollege.perc_asianpacific {
                newCollege.perc_asianpacific = urPerc_asianpacific}

//            newCollege.admission_rate = withUrCollege.admission_rate!
            if let urAdmission_rate = withUrCollege.admission_rate {
                newCollege.admission_rate = urAdmission_rate}

//            newCollege.perc_mixed = withUrCollege.perc_mixed!
            if let urPerc_mixed = withUrCollege.perc_mixed {
                newCollege.perc_mixed = urPerc_mixed}

//            newCollege.perc_aliens = withUrCollege.perc_aliens!
            if let urPerc_aliens = withUrCollege.perc_aliens {
                newCollege.perc_aliens = urPerc_aliens}

//            newCollege.enrollment = withUrCollege.enrollment!
            if let urEnrollment = withUrCollege.enrollment {
                newCollege.enrollment = urEnrollment}

                        //    var men_only: Bool
            if let urMen_only = withUrCollege.men_only {
                newCollege.men_only = urMen_only}
            
                        //    var early_action_available: Bool
            if let urEarly_action_available = withUrCollege.early_action_available {
                newCollege.early_action_available = urEarly_action_available}

//            newCollege.sat_math_estimated_median = withUrCollege.sat_math_estimated_median!
            if let urSat_math_estimated_median = withUrCollege.sat_math_estimated_median {
                newCollege.sat_math_estimated_median = urSat_math_estimated_median}

//            newCollege.sat_math_high = withUrCollege.sat_math_high!
            if let urSat_math_high = withUrCollege.sat_math_high {
                newCollege.sat_math_high = urSat_math_high}

//            newCollege.graduation_rate = withUrCollege.graduation_rate!
            if let urGraduation_rate = withUrCollege.graduation_rate {
                newCollege.graduation_rate = urGraduation_rate}

//            newCollege.sat_reading_low = withUrCollege.sat_reading_low!
            if let urSat_reading_low = withUrCollege.sat_reading_low {
                newCollege.sat_reading_low = urSat_reading_low}

//            newCollege.sat_reading_high = withUrCollege.sat_reading_high!
            if let urSat_reading_high = withUrCollege.sat_reading_high {
                newCollege.sat_reading_high = urSat_reading_high}

//            newCollege.sat_reading_estimated_median = withUrCollege.sat_reading_estimated_median!
            if let urSat_reading_estimated_median = withUrCollege.sat_reading_estimated_median {
                newCollege.sat_reading_estimated_median = urSat_reading_estimated_median}

//            newCollege.sat_math_low = withUrCollege.sat_math_low!
            if let urSat_math_low = withUrCollege.sat_math_low {
                newCollege.sat_math_low = urSat_math_low}

//            newCollege.sat_writing_low = withUrCollege.sat_writing_low!
            if let urSat_writing_low = withUrCollege.sat_writing_low {
                newCollege.sat_writing_low = urSat_writing_low}

//            newCollege.sat_writing_estimated_median = withUrCollege.sat_reading_estimated_median!
            if let urSat_writing_estimated_median = withUrCollege.sat_reading_estimated_median {
                newCollege.sat_writing_estimated_median = urSat_writing_estimated_median}

//            newCollege.sat_writing_high = withUrCollege.sat_writing_high!
            if let urSat_writing_high = withUrCollege.sat_writing_high {
                newCollege.sat_writing_high = urSat_writing_high}

                        //    var liberal_arts: Bool
            if let urLiberal_arts = withUrCollege.liberal_arts {
                newCollege.liberal_arts = urLiberal_arts}

//            newCollege.early_decision_admission_rate = withUrCollege.early_decision_admission_rate!
            if let urEarly_decision_admission_rate = withUrCollege.early_decision_admission_rate {
                newCollege.early_decision_admission_rate = urEarly_decision_admission_rate}

                        //    var early_action_is_restrictive: Bool
            if let urEarly_action_is_restrictive = withUrCollege.early_action_is_restrictive {
                newCollege.early_action_is_restrictive = urEarly_action_is_restrictive}

//            newCollege.early_action_admission_rate = withUrCollege.early_action_admission_rate!
            if let urEarly_action_admission_rate = withUrCollege.early_action_admission_rate {
                newCollege.early_action_admission_rate = urEarly_action_admission_rate}


            
            realm.add(newCollege, update: true)
        }
    }
}


func TryThisJSONRequest() {

    Alamofire.request(.GET, URLString).validate().responseObject {
        (response: Response<CollegeJSONArray, NSError>) in

        switch response.result {
        case .Success (let data):
            
            for urCollege in data.showArray! {
                print(urCollege.admitster_id)
                print(urCollege.model)
                print(urCollege.pk)
                print(urCollege.examsRequired)
                
                PutThatInTheRealm(urCollege)
            }
        case .Failure(let error):
            print("Request failed with error: \(error)")
        }
    }
}


class CollegeJSON: ResponseJSONObjectSerializable {
    
    var pk: Int?
    var model: String?
    var admitster_id: Int?
    var control: String?
    var name: String?
    var examsRequired: String?
    var base_cost: Int?
    var city: String?
    var census_region: String?
    var main_web: String?
    var religious_affiliation: String?
    var state: String?
    var cmschools_id: Int?
    var zip_code: String?
    var metropolitan_status: String?
    var tel_num: String?
    var in_state_tuition_cost: Int?
    var collegeboard_id: Int?
    var student_faculty_ratio: Int?
    var unit_id: String?
    var street_address: String?
    var has_greek_life: Bool?
    var admission_yield: Int?
    var perc_unknown: Float?
    var act_composite_estimated_median: Int?
    var women_only: Bool?
    var out_state_tuition_cost: Int?
    var perc_hawaiian: Float?
    var perc_black: Float?
    var perc_white: Float?
    var undergrad_enrollment: Int?
    var act_composite_low: Int?
    var perc_native: Float?
    var perc_hispanic: Float?
    var perc_with_fin_aid: Float?
    var act_composite_high: Int?
    var early_decision_available: Bool?
    var perc_asianpacific: Float?
    var admission_rate: Int?
    var perc_mixed: Float?
    var perc_aliens: Float?
    var enrollment: Int?
    var men_only: Bool?
    var early_action_available: Bool?
    var sat_math_estimated_median: Int?
    var sat_math_high: Int?
    var graduation_rate: Int?
    var sat_reading_low: Int?
    var sat_reading_high: Int?
    var sat_reading_estimated_median: Int?
    var sat_math_low: Int?
    var sat_writing_low: Int?
    var sat_writing_estimated_median: Int?
    var sat_writing_high: Int?
    var liberal_arts: Bool?
    var early_decision_admission_rate: Int?
    var early_action_is_restrictive: Bool?
    var early_action_admission_rate: Int?
    
    
    required init?(json: JSON) {
        
        self.pk = json["pk"].int
        self.model = json["model"].string
        self.admitster_id = json["fields"]["admitster_id"].int
        self.control = json["fields"]["control"].string
        self.name = json["fields"]["name"].string
        self.examsRequired = json["fields"]["exams_required"].string
        self.base_cost = json["fields"]["admitster_id"].int
        self.city = json["fields"]["city"].string
        self.census_region = json["fields"]["census_region"].string
        self.main_web = json["fields"]["main_web"].string
        self.religious_affiliation = json["fields"]["religious_affiliation"].string
        self.state = json["fields"]["state"].string
        self.cmschools_id = json["fields"]["cmschools_id"].int
        self.zip_code = json["fields"]["zip_code"].string
        self.metropolitan_status = json["fields"]["metropolitan_status"].string
        self.tel_num = json["fields"]["tel_num"].string
        self.in_state_tuition_cost = json["fields"]["in_state_tuition_cost"].int
        self.collegeboard_id = json["fields"]["collegeboard_id"].int
        self.student_faculty_ratio = json["fields"]["student_faculty_ratio"].int
        self.unit_id = json["fields"]["unit_id"].string
        self.street_address = json["fields"]["street_address"].string
        self.has_greek_life = json["fields"]["has_greek_life"].bool
        self.admission_yield = json["fields"]["admission_yield"].int
        self.perc_unknown = json["fields"]["perc_unknown"].float
        self.act_composite_estimated_median = json["fields"]["act_composite_estimated_median"].int
        self.women_only = json["fields"]["women_only"].bool
        self.out_state_tuition_cost = json["fields"]["out_state_tuition_cost"].int
        self.perc_hawaiian = json["fields"]["perc_hawaiian"].float
        self.perc_black = json["fields"]["perc_black"].float
        self.perc_white = json["fields"]["perc_white"].float
        self.undergrad_enrollment = json["fields"]["undergrad_enrollment"].int
        self.act_composite_low = json["fields"]["act_composite_low"].int
        self.perc_native = json["fields"]["perc_native"].float
        self.perc_hispanic = json["fields"]["perc_hispanic"].float
        self.perc_with_fin_aid = json["fields"]["perc_with_fin_aid"].float
        self.act_composite_high = json["fields"]["act_composite_high"].int
        self.early_decision_available = json["fields"]["early_decision_available"].bool
        self.perc_asianpacific = json["fields"]["perc_asianpacific"].float
        self.admission_rate = json["fields"]["admission_rate"].int
        self.perc_mixed = json["fields"]["perc_mixed"].float
        self.perc_aliens = json["fields"]["perc_aliens"].float
        self.enrollment = json["fields"]["enrollment"].int
        self.men_only = json["fields"]["men_only"].bool
        self.early_action_available = json["fields"]["early_action_available"].bool
        self.sat_math_estimated_median = json["fields"]["sat_math_estimated_median"].int
        self.sat_math_high = json["fields"]["sat_math_high"].int
        self.graduation_rate = json["fields"]["graduation_rate"].int
        self.sat_reading_low = json["fields"]["sat_reading_low"].int
        self.sat_reading_high = json["fields"]["sat_reading_high"].int
        self.sat_reading_estimated_median = json["fields"]["sat_reading_estimated_median"].int
        self.sat_math_low = json["fields"]["sat_math_low"].int
        self.sat_writing_low = json["fields"]["sat_writing_low"].int
        self.sat_writing_estimated_median = json["fields"]["sat_writing_estimated_median"].int
        self.sat_writing_high = json["fields"]["sat_writing_high"].int
        self.liberal_arts = json["fields"]["liberal_arts"].bool
        self.early_decision_admission_rate = json["fields"]["early_decision_admission_rate"].int
        self.early_action_is_restrictive = json["fields"]["early_action_is_restrictive"].bool
        self.early_action_admission_rate = json["fields"]["early_action_admission_rate"].int
    }
    
    required init() { }
}

class CollegeJSONArray: ResponseJSONObjectSerializable {
    
    var showArray: [CollegeJSON]?
    
    required init?(json: JSON) {
        
        if let arrayJson = json.array {
            self.showArray = []
            
            for json in arrayJson {
                let instance = CollegeJSON(json: json)
                self.showArray?.append(instance!)
            }
        }
    }
    
    required init() { }
}


public protocol ResponseJSONObjectSerializable {
    init?(json: SwiftyJSON.JSON)
}


extension Alamofire.Request {
    public func responseObject<T: ResponseJSONObjectSerializable>(completionHandler:
        Response<T, NSError> -> Void) -> Self {
            let serializer = ResponseSerializer<T, NSError> { request, response, data, error in
                guard error == nil else {
                    return .Failure(error!)
                }
                guard let responseData = data else {
                    let failureReason = "Object could not be serialized because input data was nil."
                    let error = Error.errorWithCode(.DataSerializationFailed, failureReason:
                        failureReason)
                    return .Failure(error)
                }
                let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
                let result = JSONResponseSerializer.serializeResponse(request, response,
                    responseData, error)
                switch result {
                case .Success(let value):
                    let json = SwiftyJSON.JSON(value)
                    if let object = T(json: json) {
                        return .Success(object)
                    } else {
                        let failureReason = "Object could not be created from JSON."
                        let error = Error.errorWithCode(.JSONSerializationFailed, failureReason:
                            failureReason)
                        return .Failure(error)
                    }
                case .Failure(let error):
                    return .Failure(error)
                }
            }
            return response(responseSerializer: serializer, completionHandler: completionHandler)
    }
}

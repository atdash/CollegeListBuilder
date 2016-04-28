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

let URLString = "http://localhost/colleges-two.json"

/*
Alamofire.request(.POST, "http://localhost/colleges-two.json", parameters:parameters, encoding: .JSON) .responseJSON
    {
        (request, response, data, error) in
        
        var json = JSON(data!)
        
        println(json)
        println(json["productList"][1])
        
}

let URLString = "http://localhost/colleges-two.json"

Alamofire.request(.GET, URLString, parameters: ["foo": "bar"])
    .responseJSON { request, response, result in
        switch result {
        case .Success(let JSON):
            print("Success with JSON: \(JSON)")
            
        case .Failure(let data, let error):
            print("Request failed with error: \(error)")
            
            if let data = data {
                print("Response data: \(NSString(data: data, encoding: NSUTF8StringEncoding)!)")
            }
        }
}

*/

func PutThatInTheRealm (withUrCollege: CollegeJSON) {

    let realm = try! Realm()
    
    do {
        try! realm.write {
            
            let newCollege = College()
            
            newCollege.model = withUrCollege.model!
            newCollege.admitster_id = withUrCollege.admitster_id!
            
            realm.add(newCollege)
            
        }
    }
}


func TryThisJSONRequest() {

    Alamofire.request(.GET, URLString).validate().responseObject {
        (response: Response<CollegeJSONArray, NSError>) in

//    Alamofire.request(.GET, URLString).validate().responseJSON {response in

        switch response.result {
        case .Success (let data):
            
            for urCollege in data.showArray! {
                print(urCollege.admitster_id)
                print(urCollege.model)
                print(urCollege.pk)
                
                PutThatInTheRealm(urCollege)
            }
        case .Failure(let error):
            print("Request failed with error: \(error)")
        }
    }
    
            
//            let json = JSON(data)
//            print(json)
            
//            if let jsonResults = response.result.value {
//            if let jsonResults = data. {
//                for urCollege in jsonResults.showArray! {
//                    print(urCollege)
//                }
            
                
                
//                let urColleges = jsonResults
                
//                for urCollege in urColleges.showArray {
//                    Realm.create(self.Realm)
//                }
            }
/*
            let model_0 = json[0]["model"].stringValue
            let model_1 = json[1]["model"].stringValue
            let pk_0 = json[0]["pk"].int
            let pk_1 = json[1]["pk"].int
            let admidster_id_0 = json[0]["fields"]["admitster_id"].int
            let admidster_id_1 = json[1]["fields"]["admitster_id"].int
            
            print(model_0, model_1)
            print(pk_0, pk_1)
            print(admidster_id_0)
            print(admidster_id_1)
*/
//        case .Failure(let error):
//            print("Request failed with error: \(error)")
//        }
//    }
//
//}


class CollegeJSON: ResponseJSONObjectSerializable {
    
    var model: String?
    var pk: Int?
    var admitster_id: Int?
    
    required init?(json: JSON) {
        
//        self.model = json[0]["model"].string
//        self.pk = json[0]["pk"].int
//        self.admitster_id = json[0]["fields"]["admitster_id"].int

        self.model = json["model"].string
        self.pk = json["pk"].int
        self.admitster_id = json["fields"]["admitster_id"].int

    
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

/*
/*
*   Helper functions for JSON import
*   Credit to Oscar Swanros!
*/

protocol JSONParselable {
    static func withJSON(json: [String:AnyObject]) -> Self?
}

func flatten<A>(x: A??) -> A? {
    if let y = x { return y }
    return nil
}

infix operator >>>= {}
func >>>= <A, B> (optional: A?, f: A -> B?) -> B? {
    return flatten(optional.map(f))
}

func number(input: [NSObject:AnyObject], key: String) -> NSNumber? {
    return input[key] >>>= { $0 as? NSNumber }
}

func int(input: [NSObject:AnyObject], key: String) -> Int? {
    return number(input, key: key).map { $0.integerValue }
}

func float(input: [NSObject:AnyObject], key: String) -> Float? {
    return number(input, key: key).map { $0.floatValue }
}

func double(input: [NSObject:AnyObject], key: String) -> Double? {
    return number(input, key: key).map { $0.doubleValue }
}

func string(input: [String:AnyObject], key: String) -> String? {
    return input[key] >>>= { $0 as? String }
}

func bool(input: [String:AnyObject], key: String) -> Bool? {
    return number(input, key: key).map { $0.boolValue }
}



struct JSONfields {
    
    let control: String
    let admitster_id: Int
    let name: String
    let examsRequired: String
    let base_cost: Int
    let city: String
    let census_region: String
    let main_web: String
    let religious_affiliation: String
    let state: String
    let cmschools_id: Int
    let zip_code: String
    let metropolitan_status: String
    let tel_num: String
    let in_state_tuition_cost: Int
    let collegeboard_id: Int
    let student_faculty_ratio: Int
    let unit_id: String
    let street_address: String
    let has_greek_life: Bool
    let admission_yield: Int
    let perc_unknown: Float
    let act_composite_estimated_median: Int
    let women_only: Bool
    let out_state_tuition_cost: Int
    let perc_hawaiian: Float
    let perc_black: Float
    let perc_white: Float
    let undergrad_enrollment: Int
    let act_composite_low: Int
    let perc_native: Float
    let perc_hispanic: Float
    let perc_with_fin_aid: Int
    let act_composite_high: Int
    let early_decision_available: Bool
    let perc_asianpacific: Float
    let admission_rate: Int
    let perc_mixed: Float
    let perc_aliens: Float
    let enrollment: Int
    let men_only: Bool
    let early_action_available: Bool
    let sat_math_estimated_median: Int
    let sat_math_high: Int
    let graduation_rate: Int
    let sat_reading_low: Int
    let sat_reading_high: Int
    let sat_reading_estimated_median: Int
    let sat_math_low: Int
    let sat_writing_low: Int
    let sat_writing_estimated_median: Int
    let sat_writing_high: Int
    let liberal_arts: Bool
    let early_decision_admission_rate: Int
    let early_action_is_restrictive: Bool
    let early_action_admission_rate: Int
    
    init (
        control: String,
        admitster_id: Int,
        name: String,
        examsRequired: String? = nil,
        base_cost: Int? = nil,
        city: String,
        census_region: String? = nil,
        main_web: String? = nil,
        religious_affiliation: String? = nil,
        state: String,
        cmschools_id: Int,
        zip_code: String,
        metropolitan_status: String,
        tel_num: String? = nil,
        in_state_tuition_cost: Int? = nil,
        collegeboard_id: Int,
        student_faculty_ratio: Int? = nil,
        unit_id: String? = nil,
        street_address: String,
        has_greek_life: Bool? = nil,
        admission_yield: Int? = nil,
        perc_unknown: Float? = nil,
        act_composite_estimated_median: Int? = nil,
        women_only: Bool? = nil,
        out_state_tuition_cost: Int? = nil,
        perc_hawaiian: Float? = nil,
        perc_black: Float? = nil,
        perc_white: Float? = nil,
        undergrad_enrollment: Int? = nil,
        act_composite_low: Int? = nil,
        perc_native: Float? = nil,
        perc_hispanic: Float? = nil,
        perc_with_fin_aid: Int? = nil,
        act_composite_high: Int? = nil,
        early_decision_available: Bool? = nil,
        perc_asianpacific: Float? = nil,
        admission_rate: Int? = nil,
        perc_mixed: Float? = nil,
        perc_aliens: Float? = nil,
        enrollment: Int? = nil,
        men_only: Bool? = nil,
        early_action_available: Bool? = nil,
        sat_math_estimated_median: Int? = nil,
        sat_math_high: Int? = nil,
        graduation_rate: Int? = nil,
        sat_reading_low: Int? = nil,
        sat_reading_high: Int? = nil,
        sat_reading_estimated_median: Int? = nil,
        sat_math_low: Int? = nil,
        sat_writing_low: Int? = nil,
        sat_writing_estimated_median: Int? = nil,
        sat_writing_high: Int? = nil,
        liberal_arts: Bool? = nil,
        early_decision_admission_rate: Int? = nil,
        early_action_is_restrictive: Bool? = nil,
        early_action_admission_rate: Int? = nil
        ) {
            self.control = control
            self.admitster_id = admitster_id
            self.name = name
            self.examsRequired = examsRequired!
            self.base_cost = base_cost!
            self.city = city
            self.census_region = census_region!
            self.main_web = main_web!
            self.religious_affiliation = religious_affiliation!
            self.state = state
            self.cmschools_id = cmschools_id
            self.zip_code = zip_code
            self.metropolitan_status = metropolitan_status
            self.tel_num = tel_num!
            self.in_state_tuition_cost = in_state_tuition_cost!
            self.collegeboard_id = collegeboard_id
            self.student_faculty_ratio = student_faculty_ratio!
            self.unit_id = unit_id!
            self.street_address = street_address
            self.has_greek_life = has_greek_life!
            self.admission_yield = admission_yield!
            self.perc_unknown = perc_unknown!
            self.act_composite_estimated_median = act_composite_estimated_median!
            self.women_only = women_only!
            self.out_state_tuition_cost = out_state_tuition_cost!
            self.perc_hawaiian = perc_hawaiian!
            self.perc_black = perc_black!
            self.perc_white = perc_white!
            self.undergrad_enrollment = undergrad_enrollment!
            self.act_composite_low = act_composite_low!
            self.perc_native = perc_native!
            self.perc_hispanic = perc_hispanic!
            self.perc_with_fin_aid = perc_with_fin_aid!
            self.act_composite_high = act_composite_high!
            self.early_decision_available = early_decision_available!
            self.perc_asianpacific = perc_asianpacific!
            self.admission_rate = admission_rate!
            self.perc_mixed = perc_mixed!
            self.perc_aliens = perc_aliens!
            self.enrollment = enrollment!
            self.men_only = men_only!
            self.early_action_available = early_action_available!
            self.sat_math_estimated_median = sat_math_estimated_median!
            self.sat_math_high = sat_math_high!
            self.graduation_rate = graduation_rate!
            self.sat_reading_low = sat_reading_low!
            self.sat_reading_high = sat_reading_high!
            self.sat_reading_estimated_median = sat_reading_estimated_median!
            self.sat_math_low = sat_math_low!
            self.sat_writing_low = sat_writing_low!
            self.sat_writing_estimated_median = sat_writing_estimated_median!
            self.sat_writing_high = sat_writing_high!
            self.liberal_arts = liberal_arts!
            self.early_decision_admission_rate = early_decision_admission_rate!
            self.early_action_is_restrictive = early_action_is_restrictive!
            self.early_action_admission_rate = early_action_admission_rate!
    }

}

struct JSONcollege {
    let pk: Int
    let model: String
    let JSONcollegeFields: [JSONfields]
    
    init(
        pk: Int,
        model: String,
        JSONcollegeFields: [JSONfields]
        ) {
            self.pk = pk
            self.model = model
            self.JSONcollegeFields = JSONcollegeFields
    }
}


extension JSONfields: JSONParselable {
    static func withJSON(json: [String : AnyObject]) -> JSONfields? {
        guard
        let control = string(json, key: "control"),
        let admitster_id = int(json, key: "admitster_id"),
        let name = string(json, key: "name"),
        let examsRequired = string(json, key: "examsRequired"),
        let base_cost = int(json, key: "base_cost"),
        let city = string(json, key: "city"),
        let census_region = string(json, key: "census_region"),
        let main_web = string(json, key: "main_web"),
        let religious_affiliation = string(json, key: "religious_affiliation"),
        let state = string(json, key: "state"),
        let cmschools_id = int(json, key: "cmschools_id"),
        let zip_code = string(json, key: "zip_code"),
        let metropolitan_status = string(json, key: "metropolitan_status"),
        let tel_num = string(json, key: "tel_num"),
        let in_state_tuition_cost = int(json, key: "in_state_tuition_cost"),
        let collegeboard_id = int(json, key: "collegeboard_id"),
        let student_faculty_ratio = int(json, key: "student_faculty_ratio"),
        let unit_id = string(json, key: "unit_id"),
        let street_address = string(json, key: "street_address"),
        let has_greek_life = bool(json, key: "has_greek_life"),
        let admission_yield = int(json, key: "admission_yield"),
        let perc_unknown = float(json, key: "perc_unknown"),
        let act_composite_estimated_median = int(json, key: "act_composite_estimated_median"),
        let women_only = bool(json, key: "women_only"),
        let out_state_tuition_cost = int(json, key: "out_state_tuition_cost"),
        let perc_hawaiian = float(json, key: "perc_hawaiian"),
        let perc_black = float(json, key: "perc_black"),
        let perc_white = float(json, key: "perc_white"),
        let undergrad_enrollment = int(json, key: "undergrad_enrollment"),
        let act_composite_low = int(json, key: "act_composite_low"),
        let perc_native = float(json, key: "perc_native"),
        let perc_hispanic = float(json, key: "perc_hispanic"),
        let perc_with_fin_aid = int(json, key: "perc_with_fin_aid"),
        let act_composite_high = int(json, key: "act_composite_high"),
        let early_decision_available = bool(json, key: "early_decision_available"),
        let perc_asianpacific = float(json, key: "perc_asianpacific"),
        let admission_rate = int(json, key: "admission_rate"),
        let perc_mixed = float(json, key: "perc_mixed"),
        let perc_aliens = float(json, key: "perc_aliens"),
        let enrollment = int(json, key: "enrollment"),
        let men_only = bool(json, key: "men_only"),
        let early_action_available = bool(json, key: "early_action_available"),
        let sat_math_estimated_median = int(json, key: "sat_math_estimated_median"),
        let sat_math_high = int(json, key: "sat_math_high"),
        let graduation_rate = int(json, key: "graduation_rate"),
        let sat_reading_low = int(json, key: "sat_reading_low"),
        let sat_reading_high = int(json, key: "sat_reading_high"),
        let sat_reading_estimated_median = int(json, key: "sat_reading_estimated_median"),
        let sat_math_low = int(json, key: "sat_math_low"),
        let sat_writing_low = int(json, key: "sat_writing_low"),
        let sat_writing_estimated_median = int(json, key: "sat_writing_estimated_median"),
        let sat_writing_high = int(json, key: "sat_writing_high"),
        let liberal_arts = bool(json, key: "liberal_arts"),
        let early_decision_admission_rate = int(json, key: "early_decision_admission_rate"),
        let early_action_is_restrictive = bool(json, key: "early_action_is_restrictive"),
        let early_action_admission_rate = int(json, key: "early_action_admission_rate")
            else {
                return nil
        }
        
        return JSONfields(control: control, admitster_id: admitster_id, name: name, examsRequired: examsRequired, base_cost: base_cost, city: city, census_region: census_region, main_web: main_web, religious_affiliation: religious_affiliation, state: state, cmschools_id: cmschools_id, zip_code: zip_code, metropolitan_status: metropolitan_status, tel_num: tel_num, in_state_tuition_cost: in_state_tuition_cost, collegeboard_id: collegeboard_id, student_faculty_ratio: student_faculty_ratio, unit_id: unit_id, street_address: street_address, has_greek_life: has_greek_life, admission_yield: admission_yield, perc_unknown: perc_unknown, act_composite_estimated_median: act_composite_estimated_median, women_only: women_only, out_state_tuition_cost: out_state_tuition_cost, perc_hawaiian: perc_hawaiian, perc_black: perc_black, perc_white: perc_white, undergrad_enrollment: undergrad_enrollment, act_composite_low: act_composite_low, perc_native: perc_native, perc_hispanic: perc_hispanic, perc_with_fin_aid: perc_with_fin_aid, act_composite_high: act_composite_high, early_decision_available: early_decision_available, perc_asianpacific: perc_asianpacific, admission_rate: admission_rate, perc_mixed: perc_mixed, perc_aliens: perc_aliens, enrollment: enrollment, men_only: men_only, early_action_available: early_action_available, sat_math_estimated_median: sat_math_estimated_median, sat_math_high: sat_math_high, graduation_rate: graduation_rate, sat_reading_low: sat_reading_low, sat_reading_high: sat_reading_high, sat_reading_estimated_median: sat_reading_estimated_median, sat_math_low: sat_math_low, sat_writing_low: sat_writing_low, sat_writing_estimated_median: sat_writing_estimated_median, sat_writing_high: sat_writing_high, liberal_arts: liberal_arts, early_decision_admission_rate: early_decision_admission_rate, early_action_is_restrictive: early_action_is_restrictive, early_action_admission_rate: early_action_admission_rate)

    }
}

extension JSONcollege {
    static func withJSON(json: [String : AnyObject]) -> JSONcollege? {
        guard
            let pk = int(json, key: "pk"),
            let model = string(json, key: "model")
            else {
                return nil
        }
        
        let JSONcollegeFieldsDicts = json["JSONCollegeFields"] as? [[String: AnyObject]]
        
        func sanitizedCollegeFields(dicts: [[String:AnyObject]]?) -> [JSONfields] {
            guard let dicts = dicts else {
                return [JSONfields]()
            }
            return dicts.flatMap {JSONfields.withJSON($0) }

        }
        
        return JSONcollege(pk: pk, model: model, JSONcollegeFields: sanitizedCollegeFields(JSONcollegeFieldsDicts))
    }
}


func dataTaskFinishedWithData(data: NSData) {
    do {
        guard
        let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String:AnyObject], JSONcollege = JSONcollege.withJSON(json)
            else {
                return
        }
        
        
        print(JSONcollege)
    } catch {
        print(error)
    }
}

func readjson(fileName: String) -> NSData{
    
    let jsonData: NSData? = NSData(contentsOfFile: fileName)
    
    return jsonData!
}
*/
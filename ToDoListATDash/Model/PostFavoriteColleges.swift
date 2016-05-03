//
//  PostFavoriteColleges.swift
//  ToDoListATDash
//
//  Created by Nicholas Salzman on 5/2/16.
//  Copyright © 2016 Nicholas Salzman. All rights reserved.
//


/*
*   @Piotr this URL should point to the Admitster back end to POST favorite colleges and receive back the JSON with
*
*   Notes:
*
*/


import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift


let URLStringResults = "http://localhost/collegesResults.json"
let URLStringPost = "http://localhost/collegesPost.json"


func PutThatInTheRealmUpdate (withUrCollege: CollegeJSONUpdate) {
    
    let realm = try! Realm()
    
    do {
        try! realm.write {
            
            let newCollege = College()
            
            if let urAdmitster_id = withUrCollege.admitster_id {
                newCollege.admitster_id = Int(urAdmitster_id)!}

            if let urAdmit_likelihood = withUrCollege.admit_likelihood {
                newCollege.admit_likelihood = urAdmit_likelihood}

            //take the admitster_id as the primary key, and update the value
            realm.add(newCollege, update: true)
            
            
            
        }
    }
}


func TryThisJSONRequestUpdate() {
    
    Alamofire.request(.GET, URLStringResults).validate().responseObject {
        (response: Response<CollegeJSONArrayUpdate, NSError>) in
        
        switch response.result {
        case .Success (let data):
            
            for urCollege in data.showArray! {
                print(urCollege.admitster_id)
                print(urCollege.admit_likelihood)
                
                PutThatInTheRealmUpdate(urCollege)
            }
            
            // Note: this will fail if the local web server is not running, which is fine if the college data does not need to be refreshed
        case .Failure(let error):
            print("Request failed with error: \(error)")
        }
    }
}


class CollegeJSONUpdate: ResponseJSONObjectSerializableUpdate {
    
    var admitster_id: String?
    var admit_likelihood: Float?
    
    
    required init?(json: JSON) {
        
        self.admitster_id = json["institutions"].string
        self.admit_likelihood = json["admit_likelihood"].float

    }
    
    required init() { }
}

class CollegeJSONArrayUpdate: ResponseJSONObjectSerializableUpdate {
    
    var showArray: [CollegeJSONUpdate]?
    
    required init?(json: JSON) {
        
        if let arrayJson = json.array {
            self.showArray = []
            
            for json in arrayJson {
                let instance = CollegeJSONUpdate(json: json)
                self.showArray?.append(instance!)
            }
        }
    }
    
    required init() { }
}


public protocol ResponseJSONObjectSerializableUpdate {
    init?(json: SwiftyJSON.JSON)
}


extension Alamofire.Request {
    public func responseObject<T: ResponseJSONObjectSerializableUpdate>(completionHandler:
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



//        self.admit_likelihood = json["portfolio_likelihoods"][0].float

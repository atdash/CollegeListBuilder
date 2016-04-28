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


func PutThatInTheRealm (withUrCollege: CollegeJSON) {

    let realm = try! Realm()
    
    do {
        try! realm.write {
            
            let newCollege = College()
            
            newCollege.model = withUrCollege.model!
            newCollege.admitster_id = withUrCollege.admitster_id!
            
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
                
                PutThatInTheRealm(urCollege)
            }
        case .Failure(let error):
            print("Request failed with error: \(error)")
        }
    }
}


class CollegeJSON: ResponseJSONObjectSerializable {
    
    var model: String?
    var pk: Int?
    var admitster_id: Int?

    
    
    
    required init?(json: JSON) {
        
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

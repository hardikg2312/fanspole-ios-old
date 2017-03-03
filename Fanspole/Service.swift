//
//  Service.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 23/02/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class Service {
    let baseUrl = "\(Constants.ApiScheme)://\(Constants.ApiHost)"
    let apiVersion = "\(Constants.ApiVersion)"
    
    static let sharedInstance = Service()
    
    func fetchEvents(completion: @escaping (JSON) -> ()){
        let headers = buildHeaders()
        Alamofire.request("\(baseUrl)\(apiVersion)\(Methods.UserCards)", headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                completion(JSON(value))
            case .failure(let err):
                print("Faild to fetch json...", err)
            }
        }
    }
    
    func fetchLeaderBoard(matchId: Int, completion: @escaping (JSON) -> ()) {
        let headers = buildHeaders()
        var mutableMethod: String = Methods.MatchLeaderBoard
        mutableMethod = substituteKeyInMethod(mutableMethod, key: "id", value: String(matchId))!
        Alamofire.request("\(baseUrl)\(apiVersion)\(mutableMethod)", headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                completion(JSON(value))
            case .failure(let err):
                print("Faild to fetch json...", err)
            }
        }
    }
    
    func fetchUserTeam(matchId: Int, completion: @escaping (JSON) -> ()) {
        let headers = buildHeaders()
        var mutableMethod: String = Methods.ViewTeam
        mutableMethod = substituteKeyInMethod(mutableMethod, key: "user_id", value: String(1))!
        mutableMethod = substituteKeyInMethod(mutableMethod, key: "match_id", value: String(matchId))!
        Alamofire.request("\(baseUrl)\(apiVersion)\(mutableMethod)", headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                completion(JSON(value))
            case .failure(let err):
                print("Faild to fetch json...", err)
            }
        }
    }
    
    private func buildHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Authorization":"Bearer d0f58a645b3afee8638dcf04363ba52e06a434394d0ffd859c0704ace7d25edd",
            "X-Fanspole-Client": "254b4f821a12144966c43444039dca21b97dde0be39b1fc1d2f573228dea6bbb"
        ]
        return headers
    }
    
    func substituteKeyInMethod(_ method: String, key: String, value: String) -> String? {
        if method.range(of: "{\(key)}") != nil {
            return method.replacingOccurrences(of: "{\(key)}", with: value)
        } else {
            return nil
        }
    }
    
}

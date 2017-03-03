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
    
    func authenticateUserLogin(email: String, password: String, completion: @escaping (JSON, Int) -> ()) {
        let headers = buildHeaders()
        let parameters: Parameters = ["grant_type" : "password", "email" : email, "password" : password]
        Alamofire.request("\(baseUrl)\(Methods.UserLogin)", method: .post, parameters: parameters, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                completion(JSON(value), (response.response?.statusCode)!)
            case .failure(let err):
                print("Faild to fetch json...", err)
            }
        }
    }
    
    func authenticateUserLoginWithRefereshToken(completion: @escaping (JSON, Int) -> ()){
        let headers = buildHeaders()
        let parameters = ["grant_type" : "refresh_token", "refresh_token" : "\(UserDefaults.standard.getRefreshToken())"]
        Alamofire.request("\(baseUrl)\(Methods.UserLogin)", method: .post, parameters: parameters, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let jsonReponse = JSON(value)
                let accessToken = jsonReponse["access_token"].stringValue
                let refreshToken = jsonReponse["refresh_token"].stringValue
                UserDefaults.standard.setAccessTokenn(value: accessToken)
                UserDefaults.standard.setRefreshToken(value: refreshToken)
                completion(JSON(value), (response.response?.statusCode)!)
            case .failure(let err):
                UserDefaults.standard.setAccessTokenn(value: "")
                UserDefaults.standard.setRefreshToken(value: "")
                print("Faild to fetch json...", err)
                completion(JSON.null, (response.response?.statusCode)!)
            }
        }
    }
    
    func fetchEvents(completion: @escaping (JSON, Int) -> ()){
        let headers = buildHeaders()
        Alamofire.request("\(baseUrl)\(apiVersion)\(Methods.UserCards)", headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                completion(JSON(value), (response.response?.statusCode)!)
            case .failure(let err):
                print("Faild to fetch json...", err)
                completion(JSON.null, (response.response?.statusCode)!)
            }
        }
    }
    
    func fetchLeaderBoard(matchId: Int, completion: @escaping (JSON, Int) -> ()) {
        let headers = buildHeaders()
        var mutableMethod: String = Methods.MatchLeaderBoard
        mutableMethod = substituteKeyInMethod(mutableMethod, key: "id", value: String(matchId))!
        Alamofire.request("\(baseUrl)\(apiVersion)\(mutableMethod)", headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                completion(JSON(value), (response.response?.statusCode)!)
            case .failure(let err):
                print("Faild to fetch json...", err)
                completion(JSON.null, (response.response?.statusCode)!)
            }
        }
    }
    
    func fetchUserTeam(matchId: Int, completion: @escaping (JSON, Int) -> ()) {
        let headers = buildHeaders()
        var mutableMethod: String = Methods.ViewTeam
        mutableMethod = substituteKeyInMethod(mutableMethod, key: "user_id", value: String(1))!
        mutableMethod = substituteKeyInMethod(mutableMethod, key: "match_id", value: String(matchId))!
        Alamofire.request("\(baseUrl)\(apiVersion)\(mutableMethod)", headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                completion(JSON(value), (response.response?.statusCode)!)
            case .failure(let err):
                print("Faild to fetch json...", err)
                completion(JSON.null, (response.response?.statusCode)!)
            }
        }
    }
    
    private func buildHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "\(Constants.ClientKey)": "\(Constants.ClientValue)",
            "Authorization":"Bearer \(UserDefaults.standard.getAccessTokenn())"
        ]
        return headers
    }
    
    private func substituteKeyInMethod(_ method: String, key: String, value: String) -> String? {
        if method.range(of: "{\(key)}") != nil {
            return method.replacingOccurrences(of: "{\(key)}", with: value)
        } else {
            return nil
        }
    }
    
}

//
//  Service.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 23/02/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON


class Service {
    let tron = TRON(baseURL: "\(Constants.ApiScheme)://\(Constants.ApiHost)")
    
    static let sharedInstance = Service()
    
    func authenticateUserLogin(email: String, password: String, completion: @escaping (JSON, Error?) -> ()) {
        let request: APIRequest<JSON, JSONError> = tron.request("\(Methods.UserLogin)")
        request.method = .post
        request.parameters = ["grant_type" : "password", "email" : email, "password" : password]
        request.perform(withSuccess: { (json) in
            completion(json, nil)
        }) { (err) in
            completion(JSON.null, err)
        }
    }
    
    func authenticateUserLoginWithRefereshToken(completion: @escaping (JSON) -> ()) {
        
        print(UserDefaults.standard.getRefreshToken())
        
        let request: APIRequest<JSON, JSONError> = tron.request("\(Methods.UserLogin)")
        request.method = .post
        request.parameters = ["grant_type" : "refresh_token", "refresh_token" : "de8fe1a742ece18a7312b1a53b435e340a39265517e8fa6921f92a4d2534ab41"]
        request.perform(withSuccess: { (response) in
            print(response["refresh_token"])
            
            let accessToken = String(describing: response["access_token"])
            let refreshToken = String(describing: response["refresh_token"])
            
            UserDefaults.standard.setIsLoggedIn(value: true)
            UserDefaults.standard.setAccessTokenn(value: accessToken)
            UserDefaults.standard.setRefreshToken(value: refreshToken)
            
            completion(response)
        }) { (err) in
            
            UserDefaults.standard.setIsLoggedIn(value: false)
            let loginController = LoginController()
            present(loginController, animated: true, completion: {})

        }
    }
    
    func fetchEvents(completion: @escaping (HomeDataSource) -> ()) {
        let request: APIRequest<HomeDataSource, JSONError> = tron.request("\(Constants.ApiVersion)\(Methods.UserCards)")
        request.headers = buildHeaders()
        request.perform(withSuccess: { (homeDataSource) in
            completion(homeDataSource)
        }) { (err) in
            if err.response?.statusCode == 401 {
                self.handleUnauthorizedResponse()
            }
            print("Faild to fetch Event Json...", err)
        }
    }
    
    func fetchLeaderBoard(matchId: Int, completion: @escaping (LeaderBoardDataSource) -> ()) {
        var mutableMethod: String = Methods.MatchLeaderBoard
        mutableMethod = substituteKeyInMethod(mutableMethod, key: "id", value: String(matchId))!
        let request: APIRequest<LeaderBoardDataSource, JSONError> = tron.request("\(Constants.ApiVersion)\(mutableMethod)")
        request.headers = buildHeaders()
        request.perform(withSuccess: { (leaderBoardDataSource) in
            completion(leaderBoardDataSource)
        }) { (err) in
            print("Faild to fetch json...", err)
        }
    }
    
    func fetchUserTeam(matchId: Int, completion: @escaping (ViewTeamDataSource) -> ()) {
        var mutableMethod: String = Methods.ViewTeam
        mutableMethod = substituteKeyInMethod(mutableMethod, key: "user_id", value: String(1))!
        mutableMethod = substituteKeyInMethod(mutableMethod, key: "match_id", value: String(matchId))!
        let request: APIRequest<ViewTeamDataSource, JSONError> = tron.request("\(Constants.ApiVersion)\(mutableMethod)")
        request.headers = buildHeaders()
        request.perform(withSuccess: { (viewTeamDataSource) in
            completion(viewTeamDataSource)
        }) { (err) in
           print("Faild to fetch json...", err)
        }
    }
    
    private func handleUnauthorizedResponse(){
        self.authenticateUserLoginWithRefereshToken { (bool) in
            print(bool)
        }
    }
    
    private func buildHeaders() -> [String : String] {
        let headersBuilder = HeaderBuilder(defaultHeaders: [Service.Constants.ClientKey : Service.Constants.ClientValue])
        let authorizationRequirement = AuthorizationRequirement.none
        let apiHeaders = headersBuilder.headers(forAuthorizationRequirement: authorizationRequirement, including: ["Authorization":"Bearer1 \(UserDefaults.standard.getAccessTokenn())"])
        return apiHeaders
    }
    
    private func substituteKeyInMethod(_ method: String, key: String, value: String) -> String? {
        if method.range(of: "{\(key)}") != nil {
            return method.replacingOccurrences(of: "{\(key)}", with: value)
        } else {
            return nil
        }
    }
    
}

class JSONError:JSONDecodable {
    required init(json: JSON) throws {
        print("JSON Error")
    }
}


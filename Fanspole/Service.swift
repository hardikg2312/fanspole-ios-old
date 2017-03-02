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
    
    func fetchEvents(completion: @escaping (HomeDataSource) -> ()) {
        let request: APIRequest<HomeDataSource, JSONError> = tron.request("\(Constants.ApiVersion)\(Methods.UserCards)")
        request.headers = buildHeaders()
        request.perform(withSuccess: { (homeDataSource) in
            completion(homeDataSource)
        }) { (err) in
            print("Faild to fetch json...", err)
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
    
    private func buildHeaders() -> [String : String] {
        let headersBuilder = HeaderBuilder(defaultHeaders: [Service.Constants.ClientKey : Service.Constants.ClientValue])
        let authorizationRequirement = AuthorizationRequirement.none
        let apiHeaders = headersBuilder.headers(forAuthorizationRequirement: authorizationRequirement, including: ["Authorization":"Bearer fddb88c854866ddd1d488bfceff67ae23e8ea3af2ab9face60c0cc6e41731a97"])
        return apiHeaders
    }
    
    func substituteKeyInMethod(_ method: String, key: String, value: String) -> String? {
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


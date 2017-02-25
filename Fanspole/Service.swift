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
    let tron = TRON(baseURL: "http://localhost:3000")
    
    static let sharedInstance = Service()
    
    func fetchEventFeed(completion: @escaping (HomeDataSource) -> ()) {
        
        let request: APIRequest<HomeDataSource, JSONError> = tron.request("/api/v2/users/cards")
        request.headers = buildHeaders()
        request.perform(withSuccess: { (homeDataSource) in
            completion(homeDataSource)
        }) { (err) in
            print("Faild to fetch json...", err)
        }
    }
    
    func fetchLeaderBoardFeed(matchId: Int, completion: @escaping (LeaderBoardDataSource) -> ()) {
        
        let request: APIRequest<LeaderBoardDataSource, JSONError> = tron.request("api/v2/matches/422/leaderboard")
        request.headers = buildHeaders()
        request.perform(withSuccess: { (leaderBoardDataSource) in
            completion(leaderBoardDataSource)
        }) { (err) in
            print("Faild to fetch json...", err)
        }
        
    }
    
    private func buildHeaders() -> [String : String] {
        let headersBuilder = HeaderBuilder(defaultHeaders: ["X-Fanspole-Client":"254b4f821a12144966c43444039dca21b97dde0be39b1fc1d2f573228dea6bbb"])
        let authorizationRequirement = AuthorizationRequirement.none
        let apiHeaders = headersBuilder.headers(forAuthorizationRequirement: authorizationRequirement, including: ["Authorization":"Bearer 79bd589f878d583042d03a807f4c8200216c5b50c6f25d834dba18088b0a2f75"])
        return apiHeaders
    }
    
}

class JSONError:JSONDecodable {
    required init(json: JSON) throws {
        print("JSON Error")
    }
}


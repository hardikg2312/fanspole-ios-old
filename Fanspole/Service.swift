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


struct Service {
    let tron = TRON(baseURL: "http://localhost:3000")
    
    static let sharedInstance = Service()
    
    func fetchEventFeed(completion: @escaping (HomeDataSource) -> ()) {
        
        let request: APIRequest<HomeDataSource, JSONError> = tron.request("/api/v2/users/cards")
        
        let headersBuilder = HeaderBuilder(defaultHeaders: ["X-Fanspole-Client":"254b4f821a12144966c43444039dca21b97dde0be39b1fc1d2f573228dea6bbb"])
        
        let authorizationRequirement = AuthorizationRequirement.none
        
        request.headers = headersBuilder.headers(forAuthorizationRequirement: authorizationRequirement, including: ["Authorization":"Bearer 6c8a56c2585a2ca1766fab010e4e3cdbd3e411a703b83f6449c058d55e7f3bff"])

        
        
        request.perform(withSuccess: { (homeDataSource) in
            //            self.datasource = homeDataSource
            completion(homeDataSource)
            
        }) { (err) in
            print("Faild to fetch json...", err)
        }
        
    }
    
    class JSONError:JSONDecodable {
        required init(json: JSON) throws {
            print("JSON Error")
        }
    }
    
}


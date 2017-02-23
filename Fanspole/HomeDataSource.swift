//
//  HomeDataSource.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 22/02/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import LBTAComponents
import TRON
import SwiftyJSON

class HomeDataSource: Datasource, JSONDecodable {
    
    let events = ["Hello", "hi"]
    
    required init(json: JSON) throws {
//        let usersJsonArray = json["users"].array
//        self.users = usersJsonArray!.map{User(json: $0)}
//        
//        let tweetJsonArray = json["tweets"].array
//        self.tweets = tweetJsonArray!.map{Tweet(json: $0)}
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [EventCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return events[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return events.count
    }
    
}

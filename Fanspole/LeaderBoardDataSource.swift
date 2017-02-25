//
//  LeaderBoardDataSource.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 25/02/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import LBTAComponents
import TRON
import SwiftyJSON

class LeaderBoardDataSource: Datasource, JSONDecodable {
    
    let members: [Member]
    
    required init(json: JSON) throws {
        var data = json["data"]
        
        guard let membersJson = data["members"].array else {
            throw NSError(domain: "com.fanspole", code: 1, userInfo: [NSLocalizedDescriptionKey: "Parsing Josn not valid"])
        }
        self.members = membersJson.map{Member(json: $0)}
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [LeaderBoardMemberCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return members[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return members.count
    }
    
}


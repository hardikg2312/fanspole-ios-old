//
//  LeaderBoardDataSource.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 25/02/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import LBTAComponents
import SwiftyJSON

class LeaderBoardDataSource: Datasource {
    
    let membersCount: Int
    let membersRank: Int
    let membersPoints: Int
    let matchInfo: String
    let members: [Member]
    
    required init(json: JSON) throws {
        var data = json["data"]
        
        guard let membersJson = data["members"].array else {
            throw NSError(domain: "com.fanspole", code: 1, userInfo: [NSLocalizedDescriptionKey: "Parsing Josn not valid"])
        }
        self.members = membersJson.map{Member(json: $0)}
        self.membersCount = data["members_count"].intValue
        self.membersRank = data["current_user_data"]["user_rank"].intValue
        self.matchInfo = "Match \(data["match"]["match_no"].stringValue) - \(data["match"]["match_stage"].stringValue)"
        self.membersPoints = data["current_user_data"]["user_points"].intValue
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [LeaderBoardHeaderCell.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [LeaderBoardMemberCell.self]
    }
    
    override func headerItem(_ section: Int) -> Any? {
        return ["membersCount" : "\(membersCount)", "membersRank" : "\(membersRank)", "membersPoints" : "\(membersPoints)", "matchInfo" : "\(matchInfo)"]
    }

    
    override func item(_ indexPath: IndexPath) -> Any? {
        return members[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return members.count
    }
    
}


//
//  Member.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 25/02/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Member {
    
    let rank: Int
    let totalScore: Int
    let id: Int
    let slug: String
    let displayName: String
    let teamName: String
    let image: String
    let country: String
    let level: Int
    let levelName: String

    init(json: JSON) {
        self.rank = json["rank"].intValue
        self.totalScore = json["total_score"].intValue
        self.id = json["id"].intValue
        self.slug = json["slug"].stringValue
        self.displayName = json["display_name"].stringValue
        self.teamName = json["team_name"].stringValue
        self.image = json["image"].stringValue
        self.country = json["country"].stringValue
        self.level = json["cricket_level"]["level"].intValue
        self.levelName = json["cricket_level"]["level_name"].stringValue
    }
}

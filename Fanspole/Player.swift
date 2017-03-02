//
//  Player.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 02/03/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Player {
    
    let id: Int
    let name: String
    let teamId: Int
    let value: Int
    let style: Int
    let score: Int
    let photoUrl: String
    var team: Team? = nil
    let lastSeriesScore: Int
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.teamId = json["team_id"].intValue
        self.value = json["value"].intValue
        self.style = json["style"].intValue
        self.photoUrl = json["photo"]["url"].stringValue
        self.score = json["score"]["total_score"].intValue
        self.lastSeriesScore = json["last_series_score"].intValue
    }
}

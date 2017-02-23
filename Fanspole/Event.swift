//
//  Event.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 22/02/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Event {
    let id: Int
    let team_created: Bool
    let event_time: String
    let event_lock_time: String
    let match_type: String
    let series_phase_id: Int
    let match_no: Int
    let match_stage: String
    let topic_id: Int
    let series: Series
    let ground: Ground
    let teamOne: Team
    let teamTwo: Team
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.team_created = json["team_created"].boolValue
        self.event_time = json["event_time"].stringValue
        self.event_lock_time = json["event_lock_time"].stringValue
        self.match_type = json["match_type"].stringValue
        self.series_phase_id = json["series_phase_id"].intValue
        self.match_no = json["match_no"].intValue
        self.match_stage = json["match_stage"].stringValue
        self.topic_id = json["topic_id"].intValue
        
        let seriesJson = json["series"]
        self.series = Series(json: seriesJson)
        
        let groundJson = json["ground"]
        self.ground = Ground(json: groundJson)
        
        let teamOneJson = json["team1"]
        self.teamOne = Team(json: teamOneJson)
        
        let teamTwoJson = json["team2"]
        self.teamTwo = Team(json: teamTwoJson)
    }
}







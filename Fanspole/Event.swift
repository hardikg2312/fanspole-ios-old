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
    let teamCreated: Bool
    let eventTime: String
    let eventLockTime: String
    let matchType: String
    let seriesPhaseId: Int
    let matchNo: Int
    let matchStage: String
    let topicId: Int
    let series: Series
    let ground: Ground
    let teamOne: Team
    let teamTwo: Team
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.teamCreated = json["team_created"].boolValue
        self.eventTime = json["event_time"].stringValue
        self.eventLockTime = json["event_lock_time"].stringValue
        self.matchType = json["match_type"].stringValue
        self.seriesPhaseId = json["series_phase_id"].intValue
        self.matchNo = json["match_no"].intValue
        self.matchStage = json["match_stage"].stringValue
        self.topicId = json["topic_id"].intValue
        
        let seriesJson = json["series"]
        self.series = Series(json: seriesJson)
        
        let groundJson = json["ground"]
        self.ground = Ground(json: groundJson)
        
        let teamOneJson = json["team1"]
        self.teamOne = Team(json: teamOneJson)
        
        let teamTwoJson = json["team2"]
        self.teamTwo = Team(json: teamTwoJson)
    }
    
//    func getEventLockTime() -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//        dateFormatter.locale = Locale.init(identifier: "en_GB")
//        let dateObj = dateFormatter.date(from: self.eventLockTime)
//        dateFormatter.dateFormat = "MMM dd' at 'h:mma"
//        return dateFormatter.string(from: dateObj!)
//    }
    
    func getEventLockTime() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale.init(identifier: "en_GB")
        let dateObj = dateFormatter.date(from: self.eventLockTime)
        return dateObj!
    }

    
    func getEventLockTimeAsString() -> String {
        let eventDate = getEventLockTime()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd' at 'h:mma"
        return dateFormatter.string(from: eventDate)
    }

    
    
    
    
}







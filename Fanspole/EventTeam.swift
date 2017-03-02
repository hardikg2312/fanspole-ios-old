//
//  EventTeam.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 02/03/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import Foundation
import SwiftyJSON

struct EventTeam {
    let id: Int
    let rank: Int
    let score: Int
    let views: Int
    let budget: String
    var eventId: Int
    var eventType: String
    let userId: Int
    let seriesId: Int
    let captain: Int
    let lastUpdatedAt: String
    var teamPlayers: [Int]
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.rank = json["rank"].intValue
        self.score = json["score"].intValue
        self.views = json["views"].intValue
        self.budget = json["budget"].stringValue
        self.eventId = json["match_d"].intValue
        self.eventType = "Match"
        self.userId = json["user_id"].intValue
        self.seriesId = json["series_id"].intValue
        self.captain = json["captain"].intValue
        self.teamPlayers = json["team_players"].arrayValue.map({$0.intValue})
        self.lastUpdatedAt = json["last_updated_at"].stringValue
        
        if self.eventId == 0 {
            self.eventId = json["round_id"].intValue
            self.eventType = "Round"
        }
    }
    
    func getLastUpdatedAtTime() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale.init(identifier: "en_GB")
        let dateObj = dateFormatter.date(from: self.lastUpdatedAt)
        return dateObj!
    }
    
    func getLastUpdatedAtTimeAsString() -> String {
        let eventDate = getLastUpdatedAtTime()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd' at 'h:mma"
        return dateFormatter.string(from: eventDate)
    }
    
}

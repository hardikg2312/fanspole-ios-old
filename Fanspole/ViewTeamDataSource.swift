//
//  ViewTeamDataSource.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 02/03/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import LBTAComponents
import SwiftyJSON

class ViewTeamDataSource: Datasource {
    
    let players: [Player]
    let eventTeam: EventTeam
    let match: Event
    
    required init(json: JSON) throws {
        var data = json["data"]
        guard let playerJson = data["team_players"].array else {
            throw NSError(domain: "com.fanspole", code: 1, userInfo: [NSLocalizedDescriptionKey: "Parsing Josn not valid"])
        }
        self.players = playerJson.map{Player(json: $0)}
        
        self.eventTeam = EventTeam(json: data["team"])
        self.match = Event(json: data["match"])
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [ViewTeamHeaderCell.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [ViewTeamPlayerCell.self]
    }
    
    override func headerItem(_ section: Int) -> Any? {
        return ["eventTeam" : self.eventTeam, "event" : self.match]
    }
    
    
    override func item(_ indexPath: IndexPath) -> Any? {
//        return players[indexPath.item]
        return ["player" : players[indexPath.item], "eventTeam" : self.eventTeam, "event" : self.match ]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return players.count
    }
    
}



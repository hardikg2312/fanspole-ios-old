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
    
    let events: [Event]
    
    required init(json: JSON) throws {
        let data = json["data"]
        guard let upcoimgMatch = data["upcoming_matches"].array else {
            throw NSError(domain: "com.fanspole", code: 1, userInfo: [NSLocalizedDescriptionKey: "Parsing Josn not valid"])
        }
        self.events = upcoimgMatch.map{Event(json: $0)}
        
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

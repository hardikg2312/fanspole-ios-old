//
//  Team.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 23/02/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Team {
    let id: Int
    let name: String
    let name_attr: String
    let slug: String
    let team_color: String
    let captain_id: Int
    let topic_id: Int
    let falg_photo: String
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.name_attr = json["name_attr"].stringValue
        self.slug = json["slug"].stringValue
        self.team_color = json["team_color"].stringValue
        self.captain_id = json["captain_id"].intValue
        self.topic_id = json["topic_id"].intValue
        self.falg_photo = json["slfalg_photoug"].stringValue
    }
}

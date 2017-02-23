//
//  Ground.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 23/02/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Ground {
    let id: Int
    let name: String
    let location: String
    let country: String
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.location = json["location"].stringValue
        self.country = json["country"].stringValue
    }
}

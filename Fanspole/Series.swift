//
//  Series.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 23/02/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Series {
    let id: Int
    let name: String
    let indexValue: Int
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.indexValue = json["index_value"].intValue
    }
}

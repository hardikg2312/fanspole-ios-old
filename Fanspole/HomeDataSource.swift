//
//  HomeDataSource.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 22/02/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import LBTAComponents

class HomeDataSource: Datasource {
    
    let events = ["Hello", "hi"]
    
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

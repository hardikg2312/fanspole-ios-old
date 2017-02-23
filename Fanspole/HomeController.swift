//
//  HomeController.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 18/02/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import LBTAComponents
import TRON
//import SwiftyJSON

class HomeController: DatasourceController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))
        collectionView!.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        Service.sharedInstance.fetchEventFeed { (homeDataSource) in
            self.datasource = homeDataSource
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 180)
    }

    
    func handleSignOut() {
        UserDefaults.standard.setIsLoggedIn(value: false)

        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
    
}

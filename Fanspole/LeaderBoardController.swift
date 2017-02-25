//
//  LeaderBoardController.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 24/02/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import UIKit
import  LBTAComponents

class LeaderBoardController: DatasourceController {
    
    var matchId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: 44))
        self.view.addSubview(navBar);
        navBar.isTranslucent = false
        navBar.backgroundColor = UIColor(red: 31/255, green: 51/255, blue: 71/255, alpha: 1)
        let navItem = UINavigationItem(title: "LeaderBoard");
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))
        
        navBar.setItems([navItem], animated: false);
        
        collectionView!.contentInset = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)
        
        collectionView!.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
//        let leaderboardDataSource = LeaderBoardDataSource()
//        self.datasource = leaderboardDataSource
        
        Service.sharedInstance.fetchLeaderBoardFeed(matchId: matchId!) { (leaderBoardDataSource) in
            self.datasource = leaderBoardDataSource
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: 50)
//    }

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 63)
    }

    func handleSignOut() {
        UserDefaults.standard.setIsLoggedIn(value: false)
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
    
    
}
 

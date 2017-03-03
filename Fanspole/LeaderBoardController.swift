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
        navBar.backgroundColor = UIColor(r: 31, g: 51, b: 71)
        let navItem = UINavigationItem(title: "LeaderBoard");
//        navItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        navBar.setItems([navItem], animated: false);
        
        collectionView!.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        collectionView!.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
//        Service.sharedInstance.fetchLeaderBoard(matchId: matchId!) { (leaderBoardDataSource) in
//            self.datasource = leaderBoardDataSource
//        }
        
        Service.sharedInstance.fetchLeaderBoard(matchId: matchId!) { (response) in
            do {
                let leaderBoardDataSource = try LeaderBoardDataSource(json: response)
                self.datasource = leaderBoardDataSource
            } catch {
                print(error)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 75)
    }

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 63)
    }

//    func handleSignOut() {
//        UserDefaults.standard.setIsLoggedIn(value: false)
//        let loginController = LoginController()
//        present(loginController, animated: true, completion: nil)
//    }
    
    func goBack(){
        dismiss(animated: true, completion: nil)
    }
    
    
}
 

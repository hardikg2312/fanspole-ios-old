//
//  ViewTeamController.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 02/03/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import UIKit
import LBTAComponents

class ViewTeamController: DatasourceController {
    
    var matchId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: 44))
        self.view.addSubview(navBar);
        navBar.isTranslucent = false
        navBar.backgroundColor = UIColor(r: 31, g: 51, b: 71)
        let navItem = UINavigationItem(title: "View Team");
        //        navItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        navBar.setItems([navItem], animated: false);
        
        layout?.sectionInset = UIEdgeInsets(top: 2, left: 1, bottom: 10, right: 1)
        layout?.minimumLineSpacing = 2
        layout?.minimumInteritemSpacing = 1
        
        collectionView!.contentInset = UIEdgeInsets(top: 62, left: 0, bottom: 0, right: 0)
        collectionView!.backgroundColor = UIColor(r: 230, g: 230, b: 230)        
        
        Service.sharedInstance.fetchUserTeam(matchId: matchId!) { (viewTeamDataSource) in
            self.datasource = viewTeamDataSource
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 2, height: 85)
    }
    
    func goBack(){
        dismiss(animated: true, completion: nil)
    }
    
}

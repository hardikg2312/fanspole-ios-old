//
//  HomeController.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 18/02/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import LBTAComponents
import SwiftyJSON

protocol HomeControllerDelegate: class {
    func clickOnLeaderBoard(matchId: Int)
    func clickOnViewTeam(matchId: Int)
}

class HomeController: DatasourceController, HomeControllerDelegate {
    
    let cellId = "cellId"
    
    func clickOnLeaderBoard(matchId: Int) {
        let leaderBoardController = LeaderBoardController()
        leaderBoardController.matchId = matchId
        present(leaderBoardController, animated: true, completion: nil)
    }
    
    func clickOnViewTeam(matchId: Int) {
        let viewTeamController = ViewTeamController()
        viewTeamController.matchId = matchId
        present(viewTeamController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
//        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))
        collectionView!.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView!.register(EventCell.self, forCellWithReuseIdentifier: cellId)
        
        Service.sharedInstance.fetchEvents { (response, status) in
            if status == 401 {
                self.serviceCallForUnauthorizedApiHit()
            } else if status == 200 {
                self.setDataSource(json: response)
            }
        }
    }
    
    private func serviceCallForUnauthorizedApiHit() {
        Service.sharedInstance.authenticateUserLoginWithRefereshToken(completion: { (response, status) in
            if status == 200 {
                Service.sharedInstance.fetchEvents(completion: { (response, status) in
                    self.setDataSource(json: response)
                })
            } else {
                self.presentLoginView()
            }
        })
    }
    
    private func setDataSource(json: JSON) {
        do {
            let homeDataSource = try HomeDataSource(json: json)
            self.datasource = homeDataSource
        } catch { print(error) }
    }
    
    private func presentLoginView() {
        let loginController = LoginController()
        self.present(loginController, animated: true, completion: {})
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! EventCell
        cell.controller = self
        cell.delegate = self
        cell.datasourceItem = datasource?.item(indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 180)
    }

    
    func handleSignOut() {
        UserDefaults.standard.setIsLoggedIn(value: false)
        UserDefaults.standard.setAccessTokenn(value: "")
        UserDefaults.standard.setRefreshToken(value: "")


        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
    
}

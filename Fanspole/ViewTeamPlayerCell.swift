//
//  ViewTeamPlayerCell.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 02/03/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import Foundation
import LBTAComponents

class ViewTeamHeaderCell: DatasourceCell {
    
    override var datasourceItem: Any?{
        didSet{
            guard let data = datasourceItem as? [String: Any] else { return }
            guard let eventTeam = data["eventTeam"] as? EventTeam else { return }
            rankText.text = "Rank \n \(eventTeam.rank)"
            pointsText.text = "Points \n \(eventTeam.score)"
            budgetText.text = "Rank \n \(eventTeam.budget)"
            viewsText.text = "Rank \n \(eventTeam.views)"
            teamUpdatedTimeText.text = "Last Updated: \(eventTeam.getLastUpdatedAtTimeAsString())"
            
            guard let event = data["event"] as? Event else { return }
            teamMatchInfoText.text = "\(event.teamOne.nameAttr) vs \(event.teamTwo.nameAttr) (Match \(event.matchNo) - \(event.matchStage))"
        }
    }
    
    
    let rankText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    let pointsText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    let budgetText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    let viewsText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()

    let teamUpdatedTimeText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    let teamMatchInfoText: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor =  UIColor(r: 31, g: 51, b: 71)
        addViewTeamInfoStackView()
        
        addSubview(teamUpdatedTimeText)
        addSubview(teamMatchInfoText)
        
        teamUpdatedTimeText.anchor(rankTextContainerView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        teamMatchInfoText.anchor(teamUpdatedTimeText.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    let rankTextContainerView = UIView()
    let pointsTextContainerView = UIView()
    let budgetTextContainerView = UIView()
    let viewsTextContainerView = UIView()
    private func addViewTeamInfoStackView() {
        let viewTeamInfoStackView = UIStackView(arrangedSubviews: [rankTextContainerView, pointsTextContainerView, budgetTextContainerView, viewsTextContainerView])
        viewTeamInfoStackView.axis = .horizontal
        viewTeamInfoStackView.distribution = .fillEqually
        addSubview(viewTeamInfoStackView)
        viewTeamInfoStackView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 4, rightConstant: 0, widthConstant: 0, heightConstant: 50)

        addSubview(rankText)
        addSubview(pointsText)
        addSubview(budgetText)
        addSubview(viewsText)

        rankText.anchor(rankTextContainerView.topAnchor, left: rankTextContainerView.leftAnchor, bottom: nil, right: rankTextContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        pointsText.anchor(pointsTextContainerView.topAnchor, left: pointsTextContainerView.leftAnchor, bottom: nil, right: pointsTextContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        budgetText.anchor(budgetTextContainerView.topAnchor, left: budgetTextContainerView.leftAnchor, bottom: nil, right: budgetTextContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        viewsText.anchor(viewsTextContainerView.topAnchor, left: viewsTextContainerView.leftAnchor, bottom: nil, right: viewsTextContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
    }
    
    
}


class ViewTeamPlayerCell: DatasourceCell {
    
    override var datasourceItem: Any?{
        didSet{
            guard let data = datasourceItem as? [String: Any] else { return }
            guard let player = data["player"] as? Player else { return }
            playerName.text = player.name
            playerScore.text = "\(player.score) Pt"
            
            if player.photoUrl == "" {
                playerImage.image = #imageLiteral(resourceName: "player_default")
            } else {
                playerImage.loadImage(urlString: player.photoUrl)
            }
            
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let value = player.value as NSNumber
            let playerValueFormated = "\(numberFormatter.string(from: value)!)"
            playerValue.text = playerValueFormated
            
            guard let event = data["event"] as? Event else { return }
            if event.teamOne.id == player.teamId {
                playerTeamFlag.loadImage(urlString: event.teamOne.flagPhoto)
            } else if event.teamTwo.id == player.teamId {
                playerTeamFlag.loadImage(urlString: event.teamTwo.flagPhoto)
            }
            
            guard let eventTeam = data["eventTeam"] as? EventTeam else { return }
            if player.id == eventTeam.captain {
                self.backgroundColor = UIColor(r: 31, g: 51, b: 71)
                playerValue.textColor = .white
                playerScore.textColor = .white
                playerName.textColor = .white
            }
        }
    }

    let playerImage: CachedImageView = {
        let image = CachedImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 23
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let playerValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    
    let playerStyle: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "india")
        image.contentMode = .scaleAspectFit
        return image
    }()

    let playerTeamFlag: CachedImageView = {
        let image = CachedImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()

    let playerScore: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()

    let playerName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()

    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
        
        addSubview(playerImage)
        addSubview(playerValue)
        addSubview(playerStyle)
        addSubview(playerTeamFlag)
        addSubview(playerScore)
        addSubview(playerName)
        
        playerImage.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 46, heightConstant: 46)
        
        playerValue.anchor(self.topAnchor, left: playerImage.rightAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        playerStyle.anchor(playerValue.bottomAnchor, left: playerImage.rightAnchor, bottom: nil, right: nil, topConstant: 4, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 25, heightConstant: 20)
        
        playerTeamFlag.anchor(playerValue.bottomAnchor, left: playerStyle.rightAnchor, bottom: nil, right: nil, topConstant: 4, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 21, heightConstant: 14)
        
        playerScore.anchor(playerValue.bottomAnchor, left: playerTeamFlag.rightAnchor, bottom: nil, right: nil, topConstant: 4, leftConstant: 8, bottomConstant: 0, rightConstant: 0, widthConstant: 30, heightConstant: 20)
        
        playerName.anchor(playerStyle.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 14, leftConstant: 0, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
}

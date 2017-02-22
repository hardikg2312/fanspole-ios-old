//
//  EventCell.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 22/02/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import LBTAComponents

class EventCell: DatasourceCell{
    
    let eventTitle: UILabel = {
        let et = UILabel()
        et.text = "Match 3 (3rd T20)"
        et.textAlignment = .center
        et.font = UIFont.boldSystemFont(ofSize: 16)
        et.textColor = .white
        return et
    }()
    
    let eventTeamsOneImage: UIImageView = {
        let etimage = UIImageView()
        etimage.image = #imageLiteral(resourceName: "india")
        etimage.contentMode = .scaleAspectFill
        return etimage
    }()
    
    let eventTeamsTwoImage: UIImageView = {
        let etimage = UIImageView()
        etimage.image = #imageLiteral(resourceName: "ausflag")
        etimage.contentMode = .scaleAspectFill
        return etimage
    }()
    
    let eventTeams: UILabel = {
        let et = UILabel()
        et.text = "IND vs AUS"
        et.textAlignment = .center
        et.font = UIFont.systemFont(ofSize: 16)
        et.textColor = .white
        return et
    }()
    
    let eventGround: UILabel = {
        let eg = UILabel()
        eg.text = "Adelaide Ovel, Adelaide, Astralia"
        eg.textAlignment = .center
        eg.font = UIFont.systemFont(ofSize: 14)
        eg.textColor = .white
        return eg
    }()
    
    let eventTime: UILabel = {
        let et = UILabel()
        et.text = "Today at 14:20"
        et.textAlignment = .center
        et.font = UIFont.boldSystemFont(ofSize: 12)
        et.textColor = .white
        return et
    }()
    
    let lineSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()
    
    let lineSeparator2View: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()
    
    let leagueButton: UIButton = {
        let leagueBtn = UIButton(type: .system)
        leagueBtn.setImage(#imageLiteral(resourceName: "ic_local_atm"), for: .normal)
        leagueBtn.tintColor = .white
        return leagueBtn
    }()
    
    let leaderboardButton: UIButton = {
        let leaderboardBtn = UIButton(type: .system)
        leaderboardBtn.setImage(#imageLiteral(resourceName: "ic_format_list_numbered"), for: .normal)
        leaderboardBtn.tintColor = .white
        return leaderboardBtn
    }()
    
    let viewTeamButton: UIButton = {
        let viewTeamBtn = UIButton(type: .system)
        viewTeamBtn.setImage(#imageLiteral(resourceName: "ic_group"), for: .normal)
        viewTeamBtn.tintColor = .white
        return viewTeamBtn
    }()
    
    let matchCenterButton: UIButton = {
        let matchCenterBtn = UIButton(type: .system)
        matchCenterBtn.setTitle("Match Center", for: .normal)
        matchCenterBtn.tintColor = .white
        return matchCenterBtn
    }()
    
    let manageTeamButton: UIButton = {
        let manageTeamBtn = UIButton(type: .system)
        manageTeamBtn.setTitle("Manage Team", for: .normal)
        manageTeamBtn.tintColor = .white
        return manageTeamBtn
    }()
    

    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UIColor(red: 31/255, green: 51/255, blue: 71/255, alpha: 1)
        
        let eventTeamsOneImageContainerView = UIView()
        let eventTeamsContainerView = UIView()
        let eventTeamsTwoImageContainerView = UIView()
        
        let eventTeamInfoStackView = UIStackView(arrangedSubviews: [eventTeamsOneImageContainerView, eventTeamsContainerView, eventTeamsTwoImageContainerView])
        eventTeamInfoStackView.axis = .horizontal
        eventTeamInfoStackView.distribution = .equalSpacing
        
        addSubview(eventTitle)
        addSubview(eventTeamInfoStackView)
        addSubview(eventGround)
        addSubview(eventTime)
        addSubview(lineSeparatorView)
        addSubview(lineSeparator2View)
        
        eventTitle.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 4, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        eventGround.anchor(eventTeamInfoStackView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 4, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        eventTime.anchor(eventGround.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 4, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        lineSeparatorView.anchor(eventTime.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor)
        lineSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true

        
        
        
        eventTeamInfoStackView.anchor(eventTitle.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 4, leftConstant: 50, bottomConstant: 4, rightConstant: 50, widthConstant: 0, heightConstant: 20)
        addSubview(eventTeamsOneImage)
        addSubview(eventTeams)
        addSubview(eventTeamsTwoImage)
        
        eventTeamsOneImage.anchor(eventTeamsOneImageContainerView.topAnchor, left: eventTeamsOneImageContainerView.leftAnchor, bottom: nil, right: eventTeamsOneImageContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
        
        eventTeams.anchor(eventTeamsContainerView.topAnchor, left: eventTeamsContainerView.leftAnchor, bottom: nil, right: eventTeamsContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        
        eventTeamsTwoImage.anchor(eventTeamsTwoImageContainerView.topAnchor, left: eventTeamsTwoImageContainerView.leftAnchor, bottom: nil, right: eventTeamsTwoImageContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
        
        
        let leagueButtonContainerView = UIView()
        let leaderboardButtonContainerView = UIView()
        let viewTeamButtonContainerView = UIView()
        
        let eventButtonStackView = UIStackView(arrangedSubviews: [leagueButtonContainerView, leaderboardButtonContainerView, viewTeamButtonContainerView])
        eventButtonStackView.axis = .horizontal
        eventButtonStackView.distribution = .fillEqually
        
        addSubview(eventButtonStackView)

        eventButtonStackView.anchor(lineSeparatorView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 4, rightConstant: 0, widthConstant: 0, heightConstant: 28)
        addSubview(leagueButton)
        addSubview(leaderboardButton)
        addSubview(viewTeamButton)

        leagueButton.anchor(leagueButtonContainerView.topAnchor, left: leagueButtonContainerView.leftAnchor, bottom: nil, right: leagueButtonContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 25)

        leaderboardButton.anchor(leaderboardButtonContainerView.topAnchor, left: leaderboardButtonContainerView.leftAnchor, bottom: nil, right: leaderboardButtonContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 25)

        viewTeamButton.anchor(viewTeamButtonContainerView.topAnchor, left: viewTeamButtonContainerView.leftAnchor, bottom: nil, right: viewTeamButtonContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 25)
        
        lineSeparator2View.anchor(eventButtonStackView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor)
        lineSeparator2View.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        
        let matchCenterButtonContainerView = UIView()
        let manageTeamButtonContainerView = UIView()
        
        let eventButton2StackView = UIStackView(arrangedSubviews: [matchCenterButtonContainerView, manageTeamButtonContainerView])
        eventButton2StackView.axis = .horizontal
        eventButton2StackView.distribution = .fillEqually
        
        addSubview(eventButton2StackView)
        
        eventButton2StackView.anchor(lineSeparator2View.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 4, rightConstant: 0, widthConstant: 0, heightConstant: 28)
        addSubview(matchCenterButton)
        addSubview(manageTeamButton)
        
        matchCenterButton.anchor(matchCenterButtonContainerView.topAnchor, left: matchCenterButtonContainerView.leftAnchor, bottom: nil, right: matchCenterButtonContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 25)
        
        manageTeamButton.anchor(manageTeamButtonContainerView.topAnchor, left: manageTeamButtonContainerView.leftAnchor, bottom: nil, right: manageTeamButtonContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 25)


        
        
    }
}

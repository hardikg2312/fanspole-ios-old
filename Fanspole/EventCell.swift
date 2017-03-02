//
//  EventCell.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 22/02/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import LBTAComponents

class EventCell: DatasourceCell{
    
    var classEvent: Event?
    
    override var datasourceItem: Any?{
        didSet{
            guard let event = datasourceItem as? Event else { return }
            classEvent = event
            eventTitle.text = "Match \(event.matchNo) (\(event.matchStage))"
            eventTeams.text = "\(event.teamOne.nameAttr) vs \(event.teamTwo.nameAttr)"
            eventGround.text = "\(event.ground.name) \(event.ground.location) \(event.ground.country)"
            eventTime.text = "\(event.getEventLockTimeAsString())"
            eventTeamsOneImage.loadImage(urlString: event.teamOne.flagPhoto)
            eventTeamsTwoImage.loadImage(urlString: event.teamTwo.flagPhoto)
            
            if !event.teamCreated {
                viewTeamButtonContainerView.removeFromSuperview()
                viewTeamButton.removeFromSuperview()
            }
            
            if event.getEventLockTime() < Date(){
                manageTeamButtonContainerView.removeFromSuperview()
                manageTeamButton.removeFromSuperview()
            } else {
                leaderboardButtonContainerView.removeFromSuperview()
                leaderboardButton.removeFromSuperview()
            }
        }
    }
    
    let eventTitle: UILabel = {
        let et = UILabel()
        et.textAlignment = .center
        et.font = UIFont.boldSystemFont(ofSize: 16)
        et.textColor = .white
        return et
    }()
    
    let eventTeamsOneImage: CachedImageView = {
        let etimage = CachedImageView()
        etimage.contentMode = .scaleAspectFit
        return etimage
    }()
    
    let eventTeamsTwoImage: CachedImageView = {
        let etimage = CachedImageView()
        etimage.contentMode = .scaleAspectFit
        return etimage
    }()
    
    let eventTeams: UILabel = {
        let et = UILabel()
        et.textAlignment = .center
        et.font = UIFont.systemFont(ofSize: 16)
        et.textColor = .white
        return et
    }()
    
    let eventGround: UILabel = {
        let eg = UILabel()
        eg.numberOfLines = 0
        eg.textAlignment = .center
        eg.font = UIFont.systemFont(ofSize: 12)
        eg.textColor = .white
        return eg
    }()
    
    let eventTime: UILabel = {
        let et = UILabel()
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
    
    lazy var viewTeamButton: UIButton = {
        let viewTeamBtn = UIButton(type: .system)
        viewTeamBtn.setImage(#imageLiteral(resourceName: "ic_group"), for: .normal)
        viewTeamBtn.addTarget(self, action: #selector(handleViewTeamClick), for: .touchUpInside)
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
    
    lazy var leaderboardButton: UIButton = {
        let leaderboardBtn = UIButton(type: .system)
        leaderboardBtn.setTitle("LeaderBoard", for: .normal)
        leaderboardBtn.addTarget(self, action: #selector(handleLeaderBoardClick), for: .touchUpInside)
        leaderboardBtn.tintColor = .white
        return leaderboardBtn
    }()
    
    weak var delegate: HomeControllerDelegate?
    
    func handleLeaderBoardClick() {
        if let matchId = classEvent?.id {
            delegate?.clickOnLeaderBoard(matchId: matchId)
        }
    }
    
    func handleViewTeamClick() {
        if let matchId = classEvent?.id {
            delegate?.clickOnViewTeam(matchId: matchId)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UIColor(red: 31/255, green: 51/255, blue: 71/255, alpha: 1)
        
        addSubview(eventTitle)
        addEventTeamInfoStackView()
        addSubview(eventGround)
        addSubview(eventTime)
        addSubview(lineSeparatorView)
        addSubview(lineSeparator2View)
        
        eventTitle.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 6, leftConstant: 0, bottomConstant: 6, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        eventGround.anchor(eventTeamInfoStackView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 4, leftConstant: 20, bottomConstant: 4, rightConstant: 20, widthConstant: 0, heightConstant: 0)
        eventTime.anchor(eventGround.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 4, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        lineSeparatorView.anchor(eventTime.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor)
        lineSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addEventButtonStackView()
        
        lineSeparator2View.anchor(eventButtonStackView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor)
        lineSeparator2View.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addEventButton2StackView()
    }
    

    var eventTeamInfoStackView = UIStackView()
    var eventButtonStackView = UIStackView()
    var eventButton2StackView = UIStackView()
    
    private func addEventTeamInfoStackView() {
        let eventTeamsOneImageContainerView = UIView()
        let eventTeamsContainerView = UIView()
        let eventTeamsTwoImageContainerView = UIView()
        
        eventTeamInfoStackView = UIStackView(arrangedSubviews: [eventTeamsOneImageContainerView, eventTeamsContainerView, eventTeamsTwoImageContainerView])
        eventTeamInfoStackView.axis = .horizontal
        eventTeamInfoStackView.distribution = .equalSpacing

        addSubview(eventTeamInfoStackView)
        addSubview(eventTeamsOneImage)
        addSubview(eventTeams)
        addSubview(eventTeamsTwoImage)
        
        eventTeamInfoStackView.anchor(eventTitle.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 4, leftConstant: 50, bottomConstant: 4, rightConstant: 50, widthConstant: 0, heightConstant: 20)
        eventTeamsOneImage.anchor(eventTeamsOneImageContainerView.topAnchor, left: eventTeamsOneImageContainerView.leftAnchor, bottom: nil, right: eventTeamsOneImageContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 34, heightConstant: 21)
        eventTeams.anchor(eventTeamsContainerView.topAnchor, left: eventTeamsContainerView.leftAnchor, bottom: nil, right: eventTeamsContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        eventTeamsTwoImage.anchor(eventTeamsTwoImageContainerView.topAnchor, left: eventTeamsTwoImageContainerView.leftAnchor, bottom: nil, right: eventTeamsTwoImageContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 34, heightConstant: 21)
    }
    
    
    let leagueButtonContainerView = UIView()
    let viewTeamButtonContainerView = UIView()
    
    private func addEventButtonStackView(){
        eventButtonStackView = UIStackView(arrangedSubviews: [leagueButtonContainerView, viewTeamButtonContainerView])
        eventButtonStackView.axis = .horizontal
        eventButtonStackView.distribution = .fillEqually
        
        addSubview(eventButtonStackView)
        
        eventButtonStackView.anchor(lineSeparatorView.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 4, rightConstant: 0, widthConstant: 0, heightConstant: 28)
        addSubview(leagueButton)
        addSubview(viewTeamButton)
        
        leagueButton.anchor(leagueButtonContainerView.topAnchor, left: leagueButtonContainerView.leftAnchor, bottom: nil, right: leagueButtonContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 25)
        
        viewTeamButton.anchor(viewTeamButtonContainerView.topAnchor, left: viewTeamButtonContainerView.leftAnchor, bottom: nil, right: viewTeamButtonContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 25)
    }
    
    let matchCenterButtonContainerView = UIView()
    let manageTeamButtonContainerView = UIView()
    let leaderboardButtonContainerView = UIView()
    
    private func addEventButton2StackView(){
        let eventButton2StackView = UIStackView(arrangedSubviews: [matchCenterButtonContainerView, manageTeamButtonContainerView, leaderboardButtonContainerView])
        eventButton2StackView.axis = .horizontal
        eventButton2StackView.distribution = .fillEqually
        
        addSubview(eventButton2StackView)
        
        eventButton2StackView.anchor(lineSeparator2View.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 4, rightConstant: 0, widthConstant: 0, heightConstant: 28)
        addSubview(matchCenterButton)
        addSubview(manageTeamButton)
        addSubview(leaderboardButton)
        
        matchCenterButton.anchor(matchCenterButtonContainerView.topAnchor, left: matchCenterButtonContainerView.leftAnchor, bottom: nil, right: matchCenterButtonContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 25)
        
        manageTeamButton.anchor(manageTeamButtonContainerView.topAnchor, left: manageTeamButtonContainerView.leftAnchor, bottom: nil, right: manageTeamButtonContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 25)
        
        leaderboardButton.anchor(leaderboardButtonContainerView.topAnchor, left: leaderboardButtonContainerView.leftAnchor, bottom: nil, right: leaderboardButtonContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 25)
    }
}

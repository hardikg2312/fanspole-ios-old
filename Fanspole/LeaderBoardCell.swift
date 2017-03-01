//
//  LeaderBoardMemberCell.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 25/02/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import LBTAComponents

class LeaderBoardHeaderCell: DatasourceCell {
    
    override var datasourceItem: Any?{
        didSet{
            guard let data = datasourceItem as? [String: String] else { return }
            guard let matchInfo = data["matchInfo"] else { return }
            guard let membersCount = data["membersCount"] else { return }
            guard let membersRank = data["membersRank"] else { return }
            guard let membersPoints = data["membersPoints"] else { return }
            matchText.text = "\(matchInfo)"
            membersText.text = "Members \n \(membersCount)"
            rankText.text =  "My Rank \n \(membersRank)"
            pointsText.text =  "My Rank \n \(membersPoints)"
        }
    }
    
    let matchText: UILabel = {
        let label = UILabel()
        label.text = "IU vs KK (2nd Qualifining Final)"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
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
    
    let membersText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor =  UIColor(r: 31, g: 51, b: 71)
        addSubview(matchText)
        matchText.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 25)
        addLeaderBoardInfoStackView()
    }
    
    let rankTextContainerView = UIView()
    let pointsTextContainerView = UIView()
    let membersTextContainerView = UIView()
    private func addLeaderBoardInfoStackView() {
        let leaderBoardInfoStackView = UIStackView(arrangedSubviews: [rankTextContainerView, pointsTextContainerView, membersTextContainerView])
        leaderBoardInfoStackView.axis = .horizontal
        leaderBoardInfoStackView.distribution = .fillEqually
        addSubview(leaderBoardInfoStackView)
        leaderBoardInfoStackView.anchor(matchText.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 4, rightConstant: 0, widthConstant: 0, heightConstant: 50)

        addSubview(rankText)
        addSubview(pointsText)
        addSubview(membersText)
        rankText.anchor(rankTextContainerView.topAnchor, left: rankTextContainerView.leftAnchor, bottom: nil, right: rankTextContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        pointsText.anchor(pointsTextContainerView.topAnchor, left: pointsTextContainerView.leftAnchor, bottom: nil, right: pointsTextContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        membersText.anchor(membersTextContainerView.topAnchor, left: membersTextContainerView.leftAnchor, bottom: nil, right: membersTextContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
    }
}

class LeaderBoardMemberCell: DatasourceCell {
    
    
    override var datasourceItem: Any?{
        didSet{
            guard let member = datasourceItem as? Member else { return }
            rankLable.text = "\(member.rank)"
            memberNameLable.text = "\(member.displayName)"
            memberTeamNameLable.text = "\(member.teamName)"
            memberLevelLable.text = "Level \(member.level) - \(member.levelName)"
            memberPointsLable.text = "\(member.totalScore)"
        }
    }
    
    let rankLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return  label
    }()
    
    let memberNameLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return  label
    }()
    
    let memberTeamNameLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return  label
    }()
    
    let memberLevelLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return  label
    }()
    
    let memberPointsLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return  label
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
        
        addSubview(rankLable)
        addSubview(memberNameLable)
        addSubview(memberTeamNameLable)
        addSubview(memberLevelLable)
        addSubview(memberPointsLable)
        
        rankLable.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 60)
        
        memberNameLable.anchor(self.topAnchor, left: rankLable.rightAnchor, bottom: nil, right: memberPointsLable.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 26)
        memberTeamNameLable.anchor(memberNameLable.bottomAnchor, left: rankLable.rightAnchor, bottom: nil, right: memberNameLable.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 17)
        memberLevelLable.anchor(memberTeamNameLable.bottomAnchor, left: rankLable.rightAnchor, bottom: nil, right: memberNameLable.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 17)
        memberPointsLable.anchor(topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 60)
    }

}

//
//  LeaderBoardMemberCell.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 25/02/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import LBTAComponents

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
        label.text = "1"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return  label
    }()
    
    let memberNameLable: UILabel = {
        let label = UILabel()
        label.text = "Hardik Gondaliya"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return  label
    }()
    
    let memberTeamNameLable: UILabel = {
        let label = UILabel()
        label.text = "Ghost 11"
        label.font = UIFont.systemFont(ofSize: 12)
        return  label
    }()
    
    let memberLevelLable: UILabel = {
        let label = UILabel()
        label.text = "Level 12 - Short Leg"
        label.font = UIFont.systemFont(ofSize: 12)
        return  label
    }()
    
    let memberPointsLable: UILabel = {
        let label = UILabel()
        label.text = "372"
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

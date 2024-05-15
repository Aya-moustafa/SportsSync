//
//  TeamsCollectionViewCell.swift
//  SportsSync
//
//  Created by Elham on 12/05/2024.
//

import UIKit

class TeamsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var logo: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
    
    
}


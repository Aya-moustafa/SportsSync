//
//  LatestCollectionViewCell.swift
//  SportsSync
//
//  Created by Elham on 12/05/2024.
//

import UIKit

class LatestCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var team1: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var team2: UILabel!
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
}


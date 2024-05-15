//
//  PlayerCollectionViewCell.swift
//  SportsSync
//
//  Created by Elham on 13/05/2024.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerTyper: UILabel!
    @IBOutlet weak var playerNumber: UIButton!
    @IBOutlet weak var img: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
}

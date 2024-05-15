//
//  UpComingCollectionViewCell.swift
//  SportsSync
//
//  Created by Elham on 12/05/2024.
//

import UIKit

class UpComingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img2: UIImageView!
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var name2: UILabel!
    @IBOutlet weak var name1: UILabel!
    @IBOutlet weak var img1: UIImageView!
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
}

//
//  LeagueTableViewCell.swift
//  SportsSync
//
//  Created by JETSMobileLabMini4 on 11/05/2024.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryLogo: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var leagueImg: UIImageView!
    var isFavorite : Bool = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        leagueImg.layer.cornerRadius = 30
        countryLogo.layer.cornerRadius = 10
        self.contentView.layer.cornerRadius = 30
        self.contentView.layer.borderWidth = 1.0
        let secColor = UIColor(red: 64.0/255.0, green: 92.0/255.0, blue: 191.0/255.0, alpha: 1.0)
        self.contentView.layer.borderColor = secColor.cgColor

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

    
}

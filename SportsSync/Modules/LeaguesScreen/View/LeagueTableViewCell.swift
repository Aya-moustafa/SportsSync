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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        leagueImg.layer.cornerRadius = 30
        countryLogo.layer.cornerRadius = 30
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
}

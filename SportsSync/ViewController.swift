//
//  ViewController.swift
//  SportsSync
//
//  Created by Aya Mostafa on 10/05/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let apiUrl = "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=205&from=2023-01-18&to=2024-01-18&APIkey=7d926052ade18d04ebf895c2163d346ff5ad0906c66237812a5235cd56bd7257"
       
        // league "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=7d926052ade18d04ebf895c2163d346ff5ad0906c66237812a5235cd56bd7257"

        ApiService.shared.fetchDataFromAPI(url: apiUrl) { result in
            switch result {
            case .success(let leagues):
                print("Received leagues: \(leagues.count)")
            
            case .failure(let error):
                print("Error fetching leagues: \(error)")
            }
        }
    }


}


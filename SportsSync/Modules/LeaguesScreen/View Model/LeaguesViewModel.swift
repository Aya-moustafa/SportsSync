//
//  LeaguesViewModel.swift
//  SportsSync
//
//  Created by JETSMobileLabMini4 on 11/05/2024.
//

import Foundation

class LeaguesViewModel {
    //var networkService : NetworkProtocol
    var bindLeaguesToViewController : (()->()) = {}
    let urlLeagues = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=4c8f425c876d47be6be85dc7a9ab9b4928e4e812a4d47f6ecd61163c3da0845f"
    private var leaguesData : [League]?

    func loadData(endPoint : String) {
        let urlLeagues = "https://apiv2.allsportsapi.com/\(endPoint)/?met=Leagues&APIkey=4c8f425c876d47be6be85dc7a9ab9b4928e4e812a4d47f6ecd61163c3da0845f"
        ApiService.shared.fetchDataFromAPI(url: urlLeagues) { result in
            switch result {
            case.success(let leagues):
                print("Received leagues: \(leagues.count)")
                for leg in leagues {
                    print("the league is \(leg.countryName ?? "unkown")")
                }
                self.leaguesData = leagues
                self.bindLeaguesToViewController() //notify view controller
            case.failure(let error):
                print("Error fetching leagues: \(error)")
            }
        }
    }
    
    func getResultLeagues() -> [League] {
        return self.leaguesData ?? []
    }
}


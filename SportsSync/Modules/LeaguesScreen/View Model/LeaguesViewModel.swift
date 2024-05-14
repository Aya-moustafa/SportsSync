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

    private var leaguesData : [League]?

    func loadData(endPoint : String) {
        let url = "\(ApiConstants.baseUrl)/\(endPoint)"
        ApiService.shared.fetchDataFromAPI(url: url) { result in
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
    
    func saveLeagueToCoreData(league : League, sport: String) {
        CoreDataHandler.shared.saveLeagueToCD(league: league,sport: sport)
    }
}


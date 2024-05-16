//
//  LeaguesViewModel.swift
//  SportsSync
//
//  Created by JETSMobileLabMini4 on 11/05/2024.
//

import Foundation


protocol FavoriteLeaguesView{
    func updateData(leagues:[League])
}


class LeaguesViewModel {
//    //var networkService : NetworkProtocol
//<<<<<<< Updated upstream
//    var favViewModel = FavoriteViewModel()
//=======
//   
//>>>>>>> Stashed changes
    var bindLeaguesToViewController : (()->()) = {}
    var favoriteLeagues : [League] = [League]()
    private var tableViewToBeRefreshed: FavoriteLeaguesView!
    private var leaguesData : [League]?

    func loadData(endPoint : String) {
        let url = "\(ApiConstants.baseUrl)/\(endPoint)"
        ApiService.shared.fetchData(urlString: url) { (result: Result<[League], Error>)  in
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
    
    func setUpView (tableViewToBeRefreshed : FavoriteLeaguesView) {
       self.tableViewToBeRefreshed = tableViewToBeRefreshed
   }
   
    func fetchFavoriteLeagusFromCoreData() {
        favoriteLeagues = CoreDataHandler.shared.fetchLeaguesFromCoreData()
        tableViewToBeRefreshed?.updateData(leagues: favoriteLeagues)
       for leg in favoriteLeagues {
           print("favorieee legggg is \(leg.leagueName ?? "unkown")")
       }
   }
   
    
    func saveLeagueToCoreData(league : League, sport: String) {
        CoreDataHandler.shared.saveLeagueToCD(league: league,sport: sport)
    }
    
    func deleteLeagueFromCD (league : League) {
        CoreDataHandler.shared.deleteLeagueFromCoreData(league: league) {
            self.fetchFavoriteLeagusFromCoreData()
        }
    }
    
    func isFav (league : League) -> Bool
     {
        return CoreDataHandler.shared.isFavorite(favLeague: league)
    }
}


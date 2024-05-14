//
//  FavoriteViewModel.swift
//  SportsSync
//
//  Created by Aya Mostafa on 12/05/2024.
//

import Foundation

protocol FavoriteLeaguesView{
    func updateData(leagues:[League])
}


class FavoriteViewModel {
    
    var favoriteLeagues : [League] = [League]()
    private var tableViewToBeRefreshed: FavoriteLeaguesView!
    
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

    func deleteLeagueFromCD (league : League) {
        CoreDataHandler.shared.deleteLeagueFromCoreData(league: league) {
            self.fetchFavoriteLeagusFromCoreData()
        }
    }
    
    func isFav (league : League) -> Bool
     {
        return CoreDataHandler.shared.isFavorite(favLeague: league)
    }
    /*func getAllFavoriteLeagues () -> [League] {
        return self.favoriteLeagues
    }*/
}

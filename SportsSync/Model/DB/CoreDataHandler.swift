//
//  CoreData.swift
//  SportsSync
//
//  Created by Aya Mostafa on 12/05/2024.
//

import Foundation
import UIKit
import CoreData

protocol CoreDataHandlerProtocol {
  
}


class CoreDataHandler {
    public static let shared = CoreDataHandler()
    private var leaguesEntity = [LeaguesFav]()
    private init () {
    }
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    
    func saveLeagueToCD (league : League, sport : String) {
        let fetchRequest : NSFetchRequest<LeaguesFav> = LeaguesFav.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d ", league.leagueKey!)
        
        do{
            let existLeague = try context?.fetch(fetchRequest)
            if !existLeague!.isEmpty {
                //show alert
            }else {
                let newLeague = LeaguesFav(context: self.context!)
                newLeague.leagueKey = Int32 (league.leagueKey ?? 0)
                newLeague.leagueLogo = league.leagueLogo
                newLeague.leagueName = league.leagueName
                newLeague.countryKey = Int32(league.countryKey ?? 0)
                newLeague.countryName = league.countryName
                newLeague.countryLogo = league.countryLogo
                newLeague.sport = sport
                do {
                    try context?.save()
                    print("the league \(league.leagueName ?? "unknown") is inserted successfully")
                    fetchLeaguesFromCoreData()
                }
            }
        }catch let error {
            print("error fetching leagues to if this league exist or not before..\(error.localizedDescription)")
        }
    }
    
    func fetchLeaguesFromCoreData () -> [League] {
        do {
            leaguesEntity = try context!.fetch(LeaguesFav.fetchRequest())
             return handleReturnedDATA()
        }catch let error {
            print("error when fetch leagues from core data with error \(error.localizedDescription)")
        }
        return [League]()
    }
    
    func handleReturnedDATA () -> [League] {
        var preparedLeagues = [League]()
        
        for item in 0..<self.leaguesEntity.count {
            let leagueItem  = League(leagueKey: Int(self.leaguesEntity[item].leagueKey)
                                     , leagueName: self.leaguesEntity[item].leagueName
                                     , countryKey: Int (self.leaguesEntity[item].countryKey)
                                     , countryName: self.leaguesEntity[item].countryName
                                     , leagueLogo: self.leaguesEntity[item].leagueLogo
                                     , countryLogo: self.leaguesEntity[item].countryLogo)

            preparedLeagues.append(leagueItem)
        }
        
        return preparedLeagues
    }
    
    func deleteLeagueFromCoreData (league: League, completion: @escaping () -> Void) {
        let fetchRequest : NSFetchRequest<LeaguesFav> = LeaguesFav.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d ", league.leagueKey ?? 0)
        do {
            let deletedLeagues = try context?.fetch(fetchRequest)
            for league in deletedLeagues! {
                context?.delete(league)
            }
            try context?.save()
            fetchLeaguesFromCoreData()
            print("the league \(league.leagueName ?? "unkown")deleted successfully")
        }catch let error {
            print("this error happen when delete league \(error.localizedDescription)")
        }
    }
    
    
    func isFavorite(favLeague : League ) ->Bool {
        return leaguesEntity.contains(where: {$0.leagueKey == favLeague.leagueKey ?? -1})
    }
    
    
}

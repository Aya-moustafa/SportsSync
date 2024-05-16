//
//  PlayersViewModel.swift
//  SportsSync
//
//  Created by Elham on 16/05/2024.
//

import Foundation
class PlayersViewModel{
    
    let apiService = ApiService.shared
    private var players: [TeamOfPlayers] = []
    
    var bindLeaguesToViewController: (() -> Void)?
    
    func playersHandler(result: Result<[TeamOfPlayers], Error>) {
        switch result {
        case .success(let fetchedTeams):
            players = fetchedTeams
            for team in players {
                print("fetching teams: \(team.teamName ?? "default value of team name")")
            }
            bindLeaguesToViewController?()
        case .failure(let error):
            print("Error fetching teams: \(error)")
        }
    }
    
    func fetchPlayers(leagueId: Int,endPoint : String) {
        let apiUrl = "https://apiv2.allsportsapi.com/\(endPoint)/?&met=Teams&teamId=\(leagueId)&APIkey=7d926052ade18d04ebf895c2163d346ff5ad0906c66237812a5235cd56bd7257"
        apiService.fetchData(urlString: apiUrl) { (result: Result<[TeamOfPlayers], Error>) in
            self.playersHandler(result: result)
            
        }
    }
    
   
    func getPlayers()-> [Player]{
        return (players.first?.players) ?? []
    }
    func getCoaches()->Coach{
        return players.first?.coaches?.first ?? Coach(coachName: "", coachCountry: "", coachAge: "")
    }
    
    func getTeam()-> TeamOfPlayers{
        return players.first ?? TeamOfPlayers()
    }
}

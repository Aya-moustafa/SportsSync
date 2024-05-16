//
//  EventsViewModel.swift
//  SportsSync
//
//  Created by Elham on 12/05/2024.
//

import Foundation
class EventsViewModel{
    
    let apiService = ApiService.shared
    
    private var upcomingEvents: [Event] = []
        private var latestEvents: [Event] = []
     
        private var allTeams: [Team] = []
        var bindLeaguesToViewController: (() -> Void)?
    
    func upcomingEventsHandler(result: Result<[Event], Error>) {
            switch result {
            case .success(let events):
                upcomingEvents = events
                bindLeaguesToViewController?()
            case .failure(let error):
                print("Error fetching upcoming events: \(error)")
            }
        }
        
        func latestResultsHandler(result: Result<[Event], Error>) {
            switch result {
            case .success(let events):
                latestEvents = events
                self.teamsHandler(endPoint: "endPoint")
                
            case .failure(let error):
                print("Error fetching latest results: \(error)")
            }
        }
        
       
    func teamsHandler(endPoint: String){
        print(latestEvents.count)
        
        for item in latestEvents{
            print("enter loop")
            
            let team = Team(teamKey: item.homeTeamKey, teamName: item.eventHomeTeam, teamLogo: item.eventHomeTeamLogo)
        
            allTeams.append(team)
            
        }
        bindLeaguesToViewController?()
    }
    
    func fetchUpcomingEvents(leagueId: Int,endPoint : String) {
        let apiUrl = "https://apiv2.allsportsapi.com/\(endPoint)/?met=Fixtures&leagueId=\(leagueId)&from=\( getOneYearAgoDate())&to=\(getNextYearDate())&APIkey=7d926052ade18d04ebf895c2163d346ff5ad0906c66237812a5235cd56bd7257"
        apiService.fetchData(urlString: apiUrl) { (result: Result<[Event], Error>) in
          
                self.upcomingEventsHandler(result: result)
            }
        }
        
        func fetchLatestResults(leagueId: Int,endPoint : String) {
            let apiUrl = "https://apiv2.allsportsapi.com/\(endPoint)/?met=Fixtures&leagueId=\(leagueId)&from=\(get5YearsAgoDate())&to=\(getOneYearAgoDate())&APIkey=7d926052ade18d04ebf895c2163d346ff5ad0906c66237812a5235cd56bd7257"
            apiService.fetchData(urlString: apiUrl) { (result: Result<[Event], Error>) in
               self.latestResultsHandler(result: result)
              
            }
        }
        
   

   
        // MARK: - Data Access
    
        func getUpcomingEvents() -> [Event] {
            return upcomingEvents
        }
        
        func getLatestEvents() -> [Event] {
            return latestEvents
        }
        
    
    func getTeams2() -> [Team] {
        return allTeams
    }
    
        
        // MARK: - Date Helpers
        
    private func getOneYearAgoDate() -> String {
        let calendar = Calendar.current
        let oneYearAgo = calendar.date(byAdding: .year, value: -1, to: Date())!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: oneYearAgo)
    }

        private func getCurrentDate() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: Date())
        }
        
        private func getNextYearDate() -> String {
            let calendar = Calendar.current
            let nextYear = calendar.date(byAdding: .year, value: 1, to: Date())!
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: nextYear)
        }
        
        private func get5YearsAgoDate() -> String {
            let calendar = Calendar.current
            let twoYearsAgo = calendar.date(byAdding: .year, value: -3, to: Date())!
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: twoYearsAgo)
        }
    
    }
   
    

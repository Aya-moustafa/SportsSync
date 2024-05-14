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
        private var teams: [TeamOfPlayers] = []
        
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
                bindLeaguesToViewController?()
            case .failure(let error):
                print("Error fetching latest results: \(error)")
            }
        }
        
        func teamsHandler(result: Result<[TeamOfPlayers], Error>) {
            switch result {
            case .success(let fetchedTeams):
                teams = fetchedTeams
                for team in teams {
                    print("fetching teams: \(team.teamName ?? "default value of team name")")
                }
                bindLeaguesToViewController?()
            case .failure(let error):
                print("Error fetching teams: \(error)")
            }
        }
    func fetchUpcomingEvents(leagueId: String) {
            apiService.fetchEvents(leagueId: leagueId, from: getOneYearAgoDate(), to: getNextYearDate()) { result in
                self.upcomingEventsHandler(result: result)
            }
        }
        
        func fetchLatestResults(leagueId: String) {
            apiService.fetchEvents(leagueId: leagueId, from: getTwoYearsAgoDate(), to: getOneYearAgoDate()) { result in
                self.latestResultsHandler(result: result)
            }
        }
        
        func fetchTeams(teamId: String) {
            apiService.fetchTeams(teamId: teamId) { result in
                self.teamsHandler(result: result)
            }
        }
        
        // MARK: - Data Access
    
        func getUpcomingEvents() -> [Event] {
            return upcomingEvents
        }
        
        func getLatestEvents() -> [Event] {
            return latestEvents
        }
        
        func getTeams() -> [TeamOfPlayers] {
            return teams
        }
    
    func getPlayers(index:Int)-> [Player]{
        return teams[index].players ?? []
    }
    func getCoaches(index:Int)->[Coach]{
        return teams[index].coaches ?? []
    }
    
    func getTeam(index:Int)-> TeamOfPlayers{
        return teams[index]
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
        
        private func getTwoYearsAgoDate() -> String {
            let calendar = Calendar.current
            let twoYearsAgo = calendar.date(byAdding: .year, value: -2, to: Date())!
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: twoYearsAgo)
        }
    
    }
   
    

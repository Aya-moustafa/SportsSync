//
//  EventsResponse.swift
//  SportsSync
//
//  Created by JETSMobileLabMini5 on 11/05/2024.
//

import Foundation


struct EventsResponse: Codable {
    let success: Int?
    let result: [Event]?
}

// MARK: - Result
struct Event: Codable {
    let eventKey: Int?
    let eventDate, eventTime, eventHomeTeam: String?
    let homeTeamKey: Int?
    let eventAwayTeam: String?
    let awayTeamKey: Int?
    let eventFinalResult, eventQuarter: String?
    let eventStatus: String?
    let countryName: String?
    let leagueName: String?
    let leagueKey: Int?
    let leagueRound: String?
    let leagueSeason: String?
    let eventLive: String?
    let eventHomeTeamLogo, eventAwayTeamLogo: String?
    let homeTeamLogo, awayTeamLogo: String?
    let eventFirstPlayer: String?
    let firstPlayerKey: String?
    let eventSecondPlayer: String?
    let secondPlayerKey: String?
    let eventFirstPlayerLogo: String?
    let eventSecondPlayerLogo: String?
    
    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case eventAwayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case eventFinalResult = "event_final_result"
        case eventQuarter = "event_quarter"
        case eventStatus = "event_status"
        case countryName = "country_name"
        case leagueName = "league_name"
        case leagueKey = "league_key"
        case leagueRound = "league_round"
        case leagueSeason = "league_season"
        case eventLive = "event_live"
        case eventHomeTeamLogo = "event_home_team_logo"
        case eventAwayTeamLogo = "event_away_team_logo"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
        case eventFirstPlayer = "event_first_player"
        case firstPlayerKey = "first_player_key"
        case eventSecondPlayer = "event_second_player"
        case secondPlayerKey = "second_player_key"
        case eventFirstPlayerLogo = "event_first_player_logo"
        case eventSecondPlayerLogo = "event_second_player_logo"
    }
}

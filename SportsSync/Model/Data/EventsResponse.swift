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
//{"success":1,"result":[{"event_key":1158301,"event_date":"2023-01-17","event_time":"21:00","event_home_team":"Napoli","home_team_key":152,"event_away_team":"Cremonese","away_team_key":4998,"event_halftime_result":"2 - 1","event_final_result":"2 - 3","event_ft_result":"2 - 2","event_penalty_result":"4 - 5","event_status":"After Pen.","country_name":"Italy","league_name":"Coppa Italia - Round of 16","league_key":205,"league_round":"Round of 16","league_season":"2022\/2023","event_live":"0","event_stadium":"Stadio Diego Armando Maradona (Napoli)","event_referee":"M. Ferrieri Caputi","home_team_logo":"https:\/\/apiv2.allsportsapi.com\/logo\/152_napoli.jpg","away_team_logo":"https:\/\/apiv2.allsportsapi.com\/logo\/4998_cremonese.jpg","event_country_key":5,"league_logo":"https:\/\/apiv2.allsportsapi.com\/logo\/logo_leagues\/205_coppa-italia.png","country_logo":"https:\/\/apiv2.allsportsapi.com\/logo\/logo_country\/5_italy.png","event_home_formation":"4-2-3-1","event_away_formation":"3-5-2","fk_stage_key":4818,"stage_name":"Round of 16","league_group":null,"goalscorers":[{"time":"18","home_scorer":"","home_scorer_id":"","home_assist":"","home_assist_id":"","score":"0 - 1","away_scorer":"C. Pickel","away_scorer_id":"68522572","away_assist":"D. Okereke","away_assist_id":"3811106019","info":"","info_time":"1st Half"}],"substitutes":[{"time":"66","home_scorer":[],"home_assist":null,"score":"substitution","away_scorer":{"in":"C. Buonaiuto","out":"M. Castagnetti","in_id":1668743649,"out_id":2211367452},"away_assist":null,"info":null,"info_time":"2nd Half"}],"cards":[{"time":"29","home_fault":"","card":"yellow card","away_fault":"J. Vasquez","info":"","home_player_id":"","away_player_id":"2960374510","info_time":"1st Half"}],"vars":{"home_team":[],"away_team":[]},"lineups":{"home_team":{"starting_lineups":[{"player":"Alessio Zerbin","player_number":23,"player_position":10,"player_country":null,"player_key":657269409,"info_time":""}],"substitutes":[{"player":"Davide Marfella","player_number":12,"player_position":0,"player_country":null,"player_key":3507676311,"info_time":""}],"coaches":[],"missing_players":[]},"away_team":{"starting_lineups":[{"player":"Daniel Ciofani","player_number":9,"player_position":11,"player_country":null,"player_key":2469981409,"info_time":""}],"substitutes":[{"player":"Emanuel Aiwu","player_number":4,"player_position":0,"player_country":null,"player_key":3434858142,"info_time":""}],"coaches":[],"missing_players":[]}},"statistics":[{"type":"Substitution","home":"6","away":"7"}]}]}



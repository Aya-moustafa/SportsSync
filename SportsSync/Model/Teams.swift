//
//  Leagues.swift
//  SportsSync
//
//  Created by JETSMobileLabMini5 on 11/05/2024.
//

import Foundation

// MARK: - Teams
struct Teams: Codable {
    let success: Int?
    let result: [Team]?
}

// MARK: - Team
struct Team: Codable {
    let teamKey: Int?
    let teamName: String?
    let teamLogo: String?


    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
    }
}



//{"success":1,"result":[{"event_key":1348240,"event_date":"2024-01-11","event_time":"21:00","event_home_team":"Juventus","home_team_key":96,"event_away_team":"Frosinone","away_team_key":5000,"event_halftime_result":"2 - 0","event_final_result":"4 - 0","event_ft_result":"4 - 0","event_penalty_result":"","event_status":"Finished","country_name":"Italy","league_name":"Coppa Italia - Quarter-finals","league_key":205,"league_round":"Quarter-finals","league_season":"2023\/2024","event_live":"0","event_stadium":"Allianz Stadium (Torino)","event_referee":"J. Sacchi","home_team_logo":"https:\/\/apiv2.allsportsapi.com\/logo\/96_juventus.jpg","away_team_logo":"https:\/\/apiv2.allsportsapi.com\/logo\/5000_frosinone.jpg","event_country_key":5,"league_logo":"https:\/\/apiv2.allsportsapi.com\/logo\/logo_leagues\/205_coppa-italia.png","country_logo":"https:\/\/apiv2.allsportsapi.com\/logo\/logo_country\/5_italy.png","event_home_formation":"3-5-2","event_away_formation":"3-4-2-1","fk_stage_key":324,"stage_name":"Quarter-finals","league_group":null,"goalscorers":[{"time":"11","home_scorer":"A. Milik","home_scorer_id":"622912986","home_assist":"","home_assist_id":"","score":"1 - 0","away_scorer":"","away_scorer_id":"","away_assist":"","away_assist_id":"","info":"Penalty","info_time":"1st Half"}],"substitutes":[{"time":"59","home_scorer":[],"home_assist":null,"score":"substitution","away_scorer":{"in":"E. Barrenechea","out":"L. Mazzitelli","in_id":4042587242,"out_id":4269265442},"away_assist":null,"info":null,"info_time":"2nd Half"}],"cards":[{"time":"20","home_fault":"M. Locatelli","card":"yellow card","away_fault":"","info":"","home_player_id":"2512750030","away_player_id":"","info_time":"1st Half"}],"vars":{"home_team":[{"var_player_name":"Arkadiusz Milik","var_minute":"59","var_player_id":755943754,"var_type":"Goal cancelled","var_event_decision":"Goal confirmed","var_decision":"False"}],"away_team":[]},"lineups":{"home_team":{"starting_lineups":[{"player":"Kenan Yildiz","player_number":15,"player_position":11,"player_country":null,"player_key":3573468021,"info_time":""}],"coaches":[],"missing_players":[]},"away_team":{"starting_lineups":[{"player":"Abdou Harroui","player_number":21,"player_position":10,"player_country":null,"player_key":3846056688,"info_time":""}],"substitutes":[{"player":"Far\u00e8s Ghedjemis","player_number":29,"player_position":0,"player_country":null,"player_key":3993141266,"info_time":""}],"coaches":[],"missing_players":[]}},"statistics":[{"type":"Penalty","home":"1","away":"0"},{"type":"Substitution","home":"5","away":"5"},{"type":"Attacks","home":"92","away":"96"}]}]}


//{"success":1,"result":[{"team_key":250,"team_name":"AGF","team_logo":"https:\/\/apiv2.allsportsapi.com\/logo\/250_agf.jpg","players":[{"player_key":1970671126,"player_image":"https:\/\/apiv2.allsportsapi.com\/logo\/players\/2020_j-hansen.jpg","player_name":"J. Hansen","player_number":"1","player_country":null,"player_type":"Goalkeepers","player_age":"39","player_match_played":"11","player_goals":"0","player_yellow_cards":"1","player_red_cards":"0","player_injured":"No","player_substitute_out":"0","player_substitutes_on_bench":"19","player_assists":"0","player_birthdate":"1985-03-31","player_is_captain":"1","player_shots_total":"","player_goals_conceded":"9","player_fouls_committed":"","player_tackles":"","player_blocks":"","player_crosses_total":"","player_interceptions":"","player_clearances":"14","player_dispossesed":"","player_saves":"26","player_inside_box_saves":"17","player_duels_total":"3","player_duels_won":"3","player_dribble_attempts":"","player_dribble_succ":"","player_pen_comm":"","player_pen_won":"","player_pen_scored":"0","player_pen_missed":"0","player_passes":"353","player_passes_accuracy":"205","player_key_passes":"1","player_woordworks":"","player_rating":"7.03"}],"coaches":[{"coach_name":"U. R\u00f6sler","coach_country":null,"coach_age":null}]}]}

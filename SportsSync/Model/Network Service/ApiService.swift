//
//  ApiService.swift
//  SportsSync
//
//  Created by JETSMobileLabMini5 on 11/05/2024.
//

import Foundation
import Alamofire

class ApiService : NetworkProtocol {
    static let shared = ApiService()
    
    func fetchDataFromAPI(url: String, completion: @escaping (Result<[League], Error>) -> Void) {
        print("inside fetchData from api")
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let leaguesResponse = try decoder.decode(LeagueResponse.self, from: data)
                    completion(.success(leaguesResponse.result!))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchEvents(leagueId: String, from: String, to: String, completion: @escaping (Result<[Event], Error>) -> Void) {
        let apiUrl = "https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=\(leagueId)&from=\(from)&to=\(to)&APIkey=7d926052ade18d04ebf895c2163d346ff5ad0906c66237812a5235cd56bd7257"
        
        AF.request(apiUrl).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let eventsResponse = try decoder.decode(EventsResponse.self, from: data)
                    completion(.success(eventsResponse.result ?? []))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

       func fetchTeams(teamId: String, completion: @escaping (Result<[TeamOfPlayers], Error>) -> Void) {
           let apiUrl = "https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=\(teamId)&APIkey=7d926052ade18d04ebf895c2163d346ff5ad0906c66237812a5235cd56bd7257" //"https://apiv2.allsportsapi.com/football/?met=Teams&leagueId=\(leagueId)&APIkey=7d926052ade18d04ebf895c2163d346ff5ad0906c66237812a5235cd56bd7257"
           
           AF.request(apiUrl).responseData { response in
               switch response.result {
               case .success(let data):
                   do {
                       let decoder = JSONDecoder()
                       let teamsResponse = try decoder.decode(PlayerResponse.self, from: data)
                       completion(.success(teamsResponse.result ?? []))
                   } catch {
                       completion(.failure(error))
                   }
               case .failure(let error):
                   completion(.failure(error))
               }
           }
       }
    
}

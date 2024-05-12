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
}

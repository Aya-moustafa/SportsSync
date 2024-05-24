//
//  ApiService.swift
//  SportsSync
//
//  Created by JETSMobileLabMini5 on 11/05/2024.
//
//
import Foundation
import Alamofire
import Combine
class ApiService {
    private static let apiKey = "a561958487d442b893570641241805"
       private static let baseURL = "https://api.weatherapi.com/v1/forecast.json"
      
       static func fetchWeather( lat: String, lon: String, completion: @escaping (Result<Weather, Error>) -> Void) {
           let parameters: [String: String] = [
               "key": apiKey,
               "q": "\(lat),\(lon)",
               "days": "3",
               "aqi": "yes",
               "alerts": "no"
           ]
           
           AF.request(baseURL, parameters: parameters).validate().responseDecodable(of: Weather.self) { response in
               switch response.result {
               case .success(let weatherData):
                   completion(.success(weatherData))
               case .failure(let error):
                   completion(.failure(error))
               }
           }
       }
}


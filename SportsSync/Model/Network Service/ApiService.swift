//
//  ApiService.swift
//  SportsSync
//
//  Created by JETSMobileLabMini5 on 11/05/2024.
//

import Foundation
import Alamofire
struct ApiResponse<T: Codable>: Codable {
    let success: Int
    let result: [T]
}
class ApiService : NetworkProtocol {
    static let shared = ApiService()
    func fetchData<T: Codable>(urlString: String, completion: @escaping (Result<[T], Error>) -> Void) {
        AF.request(urlString).responseDecodable(of: ApiResponse<T>.self) { response in
            switch response.result {
            case .success(let apiResponse):
                completion(.success(apiResponse.result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


//
//  NetworkProtocol.swift
//  SportsSync
//
//  Created by JETSMobileLabMini4 on 11/05/2024.
//

import Foundation

protocol NetworkProtocol{
    func fetchDataFromAPI(url: String, completion: @escaping (Result<[League], Error>) -> Void)
}

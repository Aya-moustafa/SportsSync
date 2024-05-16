//
//  NetworkProtocol.swift
//  SportsSync
//
//  Created by JETSMobileLabMini4 on 11/05/2024.
//

import Foundation

protocol NetworkProtocol{
    func fetchData<T: Codable>(urlString: String, completion: @escaping (Result<[T], Error>) -> Void) 
}

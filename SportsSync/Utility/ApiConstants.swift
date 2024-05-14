//
//  ApiConstants.swift
//  SportsSync
//
//  Created by Aya Mostafa on 14/05/2024.
//

import Foundation
import Foundation

struct ApiConstants {
    static let baseUrl = "https://apiv2.allsportsapi.com"
    
    struct Endpoints {
        static let football = "/football/?met=Leagues&APIkey=4c8f425c876d47be6be85dc7a9ab9b4928e4e812a4d47f6ecd61163c3da0845f"
        static let basketball = "/basketball/?met=Leagues&APIkey=4c8f425c876d47be6be85dc7a9ab9b4928e4e812a4d47f6ecd61163c3da0845f"
        static let tennis = "/tennis/?met=Leagues&APIkey=4c8f425c876d47be6be85dc7a9ab9b4928e4e812a4d47f6ecd61163c3da0845f"
        static let cricket = "/cricket/?met=Leagues&APIkey=4c8f425c876d47be6be85dc7a9ab9b4928e4e812a4d47f6ecd61163c3da0845f"
    }
}

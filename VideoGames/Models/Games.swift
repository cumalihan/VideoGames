//
//  Games.swift
//  VideoGames
//
//  Created by Cumali Han Ünlü on 6.07.2022.
//

import UIKit


struct Games: Codable, Hashable {
    let count: Int
    let results: [ResultGame]
}

// MARK: - Result
struct ResultGame: Codable, Hashable{
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Double
}



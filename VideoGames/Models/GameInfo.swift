//
//  GameInfo.swift
//  VideoGames
//
//  Created by Cumali Han Ünlü on 9.07.2022.
//

import Foundation

struct GameInfo: Codable {
    let id: Int?
    let slug: String?
    let name: String?
    let metacritic: Int?
    let description: String?
    let backgroundImage: String?
    let rating: Double?
    let released: String?
     
    
    init(id: Int? = nil, slug: String? = nil, name: String? = nil, metacritic: Int? = nil, description: String? = nil, backgroundImage: String? = nil, rating: Double? = nil, released: String? = nil) {
        self.id = id
        self.slug = slug
        self.name = name
        self.metacritic = metacritic
        self.description = description
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.released = released
    }
}

//
//  NetworkError.swift
//  VideoGames
//
//  Created by Cumali Han Ünlü on 12.07.2022.
//

import Foundation

enum NetworkError: String, Error {
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The Data received from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this game. Please try again"
    case alreadyFavorites = "You've already favorited this game."
}

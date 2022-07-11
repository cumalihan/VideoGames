//
//  PersistenceMangaer.swift
//  VideoGames
//
//  Created by Cumali Han Ünlü on 10.07.2022.
//

import Foundation


enum PersistenceActionType {
    case add, remove
}

enum PersistenceMangaer {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: ResultGame, actionType: PersistenceActionType, completed: @escaping (NetworkError?) -> Void) {
        
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
               var retrieveFavorites = favorites
                
                switch actionType {
                case .add:
                    guard !retrieveFavorites.contains(favorite) else {
                        completed(.alreadyFavorites)
                        return
                    }
                    retrieveFavorites.append(favorite)

                case .remove:
                    retrieveFavorites.removeAll { $0.name == favorite.name }
                }
                
                completed(save(favorites: retrieveFavorites))
                
           
            case .failure(let error):
                completed(error)
            }
        }
        
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[ResultGame], NetworkError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([ResultGame].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [ResultGame]) -> NetworkError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
}

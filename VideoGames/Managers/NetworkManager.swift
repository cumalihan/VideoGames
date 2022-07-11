//
//  NetworkManager.swift
//  VideoGames
//
//  Created by Cumali Han Ünlü on 6.07.2022.
//

import UIKit


class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.rawg.io/api/games"
    private let apiKey = "?key=1e6150d2206d405d9829e208eeeb9053"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    
    func getGames(completed: @escaping(Result<Games, NetworkError>) -> Void) {
        
        let endpoint = baseURL + apiKey
 
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidResponse))
            return
            
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let game = try decoder.decode(Games.self, from: data)
                completed(.success(game))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()        
    }
    
    func getGameInfo(for id: Int, completed: @escaping(Result<GameInfo, NetworkError>) -> Void) {
        let endpoint = baseURL + "/\(id)" + apiKey
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidResponse))
            return
            
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let game = try decoder.decode(GameInfo.self, from: data)
                completed(.success(game))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
        
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                      completed(nil)
                      return
                  }
                    
                    
            self.cache.setObject(image, forKey: cacheKey)
            
            completed(image)
        }
        
        task.resume()
    }
    
    
    
    
    
}

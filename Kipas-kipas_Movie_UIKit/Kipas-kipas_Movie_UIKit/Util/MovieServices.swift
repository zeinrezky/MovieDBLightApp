//
//  MovieServices.swift
//  Kipas-kipas_Movie_UIKit
//
//  Created by zein rezky chandra on 06/07/24.
//

import Foundation

protocol MovieServiceProtocol {
    func searchMovies(query: String, completion: @escaping ([Movie]?) -> Void)
    func getNowPlaying(completion: @escaping ([Movie]?) -> Void)
    func getMovieCredits(movieId: Int, completion: @escaping ([Cast]?) -> Void)
}

class MovieService: MovieServiceProtocol {
    
    func searchMovies(query: String, completion: @escaping ([Movie]?) -> Void) {
        guard let url = URL(string: "\(Constant.API.BASE_URL+EndpointRoutingType.search.rawValue)?api_key=\(Constant.PRIVATEKEY.KEY)&query=\(query)") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                    completion(decodedResponse.results)
                } catch {
                    print("Error decoding data: \(error)")
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    func getNowPlaying(completion: @escaping ([Movie]?) -> Void) {
        guard let url = URL(string: "\(Constant.API.BASE_URL+EndpointRoutingType.now_playing.rawValue)?api_key=\(Constant.PRIVATEKEY.KEY)") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                    completion(decodedResponse.results)
                } catch {
                    print("Error decoding data: \(error)")
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    func getMovieCredits(movieId: Int, completion: @escaping ([Cast]?) -> Void) {
        guard let url = URL(string: "\(Constant.API.BASE_URL+EndpointRoutingType.movie_details.rawValue)\(movieId)/credits?api_key=\(Constant.PRIVATEKEY.KEY)") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(MovieCreditsResponse.self, from: data)
                    completion(decodedResponse.cast)
                } catch {
                    print("Error decoding data: \(error)")
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }.resume()

    }
}

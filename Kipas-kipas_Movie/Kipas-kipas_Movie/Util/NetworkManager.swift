//
//  NetworkManager.swift
//  Kipas-kipas_Movie
//
//  Created by zein rezky chandra on 05/07/24.
//

import Foundation

class NetworkService {
    private let apiKey = "a310f7b62fbf8de5beafbb10afb1343e"
    private let baseUrl = "https://api.themoviedb.org/3"
    
    func fetchMovies(query: String, page: Int = 1) async throws -> [Movie] {
        let urlString = "\(baseUrl)/search/movie?api_key=\(apiKey)&query=\(query)&page=\(page)"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(MovieResponse.self, from: data)
        return response.results
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
}

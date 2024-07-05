//
//  PersistenceServices.swift
//  Kipas-kipas_Movie
//
//  Created by zein rezky chandra on 05/07/24.
//

import Foundation

class PersistenceService {
    private let userDefaults = UserDefaults.standard
    
    func saveMovies(_ movies: [Movie]) {
        let data = try? JSONEncoder().encode(movies)
        userDefaults.set(data, forKey: "savedMovies")
    }
    
    func loadMovies() -> [Movie] {
        guard let data = userDefaults.data(forKey: "savedMovies"),
              let movies = try? JSONDecoder().decode([Movie].self, from: data) else {
            return []
        }
        return movies
    }
}

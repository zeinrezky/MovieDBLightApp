//
//  MovieModel.swift
//  Kipas-kipas_Movie_UIKit
//
//  Created by zein rezky chandra on 06/07/24.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String
    let genreIds: [Int]
    
    var releaseYear: String {
        return String(releaseDate.prefix(4))
    }
    
    var genres: [String] {
        genreIds.map { GenreMap[$0] ?? "Unknown" }
    }

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
    }
}

struct MovieResponse: Codable {
    let results: [Movie]
}

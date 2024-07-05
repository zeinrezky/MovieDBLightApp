//
//  MovieModel.swift
//  Kipas-kipas_Movie
//
//  Created by zein rezky chandra on 05/07/24.
//

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    let releaseDate: String
    let genreIds: [Int]
    
    var releaseYear: Int {
        return Int(releaseDate.prefix(4)) ?? 0
    }
    
    var genres: [String] {
        genreIds.map { GenreMap[$0] ?? "Unknown" }
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
    }
}

let GenreMap = [
    28: "Action",
    12: "Adventure",
    16: "Animation",
    35: "Comedy",
    80: "Crime",
    99: "Documentary",
    18: "Drama",
    10751: "Family",
    14: "Fantasy",
    36: "History",
    27: "Horror",
    10402: "Music",
    9648: "Mystery",
    10749: "Romance",
    878: "Science Fiction",
    10770: "TV Movie",
    53: "Thriller",
    10752: "War",
    37: "Western"
]

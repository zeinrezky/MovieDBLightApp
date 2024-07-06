//
//  Constant.swift
//  Kipas-kipas_Movie_UIKit
//
//  Created by zein rezky chandra on 06/07/24.
//

enum EndpointRoutingType: String {
    case search = "search/movie"
    case now_playing = "movie/now_playing"
    case movie_details = "movie/"
}

struct Constant {
    struct API {
        static let BASE_URL = "https://api.themoviedb.org/3/"
    }
    
    struct PRIVATEKEY {
        static let KEY = "a310f7b62fbf8de5beafbb10afb1343e"
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

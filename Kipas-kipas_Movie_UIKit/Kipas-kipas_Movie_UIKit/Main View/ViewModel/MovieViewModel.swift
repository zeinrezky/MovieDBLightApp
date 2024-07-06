//
//  MovieViewModel.swift
//  Kipas-kipas_Movie_UIKit
//
//  Created by zein rezky chandra on 06/07/24.
//

import Foundation

class MovieViewModel {
    private let movieService: MovieServiceProtocol
    private(set) var movies: [Movie] = []
    private(set) var casts: [Cast] = []
    
    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
    }
    
    func searchMovies(query: String, completion: @escaping () -> Void) {
        movieService.searchMovies(query: query) { [weak self] movies in
            self?.movies = movies ?? []
            completion()
        }
    }
    
    func getNowPlaying(completion: @escaping () -> Void) {
        movieService.getNowPlaying { [weak self] movies in
            self?.movies = movies ?? []
            completion()
        }
    }
    
    func getMovieCredits(movieId: Int, completion: @escaping () -> Void) {
        movieService.getMovieCredits(movieId: movieId) { [weak self] casts in
            self?.casts = casts ?? []
            completion()
        }
    }
}

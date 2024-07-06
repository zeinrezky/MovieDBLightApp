//
//  MovieViewModel.swift
//  Kipas-kipas_Movie_UIKit
//
//  Created by zein rezky chandra on 06/07/24.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var casts: [Cast] = []
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let movieService: MovieServiceProtocol

    init(movieService: MovieServiceProtocol = MovieService()) {
        self.movieService = movieService
    }
    
//    private let movieService: MovieServiceProtocol
//    private(set) var movies: [Movie] = []
//    private(set) var casts: [Cast] = []
//    
//    init(movieService: MovieServiceProtocol) {
//        self.movieService = movieService
//    }
    
    func getNowPlaying() {
        movieService.getNowPlaying()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] movies in
                self?.movies = movies
            })
            .store(in: &cancellables)
    }

    func searchMovies(query: String) {
        movieService.searchMovies(query: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] movies in
                self?.movies = movies
            })
            .store(in: &cancellables)
    }
    
    func getMovieCredits(movieId: Int) {
        movieService.getMovieCredits(movieId: movieId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] casts in
                self?.casts = casts
            })
            .store(in: &cancellables)
    }
    
    /*
    func searchMovies(query: String, completion: @escaping () -> Void) {
        movieService.searchMovies(query: query) { [weak self] movies in
            self?.movies = movies ?? []
            completion()
        }
    }*/
    
    /*
    func getNowPlaying(completion: @escaping () -> Void) {
        movieService.getNowPlaying { [weak self] movies in
            self?.movies = movies ?? []
            completion()
        }
    }*/
    
    /*
    func getMovieCredits(movieId: Int, completion: @escaping () -> Void) {
        movieService.getMovieCredits(movieId: movieId) { [weak self] casts in
            self?.casts = casts ?? []
            completion()
        }
    }*/
}

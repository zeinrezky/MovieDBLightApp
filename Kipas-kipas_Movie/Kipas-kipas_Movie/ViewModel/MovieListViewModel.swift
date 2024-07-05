//
//  MovieListViewModel.swift
//  Kipas-kipas_Movie
//
//  Created by zein rezky chandra on 05/07/24.
//
//
import Foundation
import Combine

@MainActor
class MovieListViewModel: ObservableObject {
    @Published var movies = [Movie]()
    @Published var query = ""
    @Published var page = 1
    private var cancellables = Set<AnyCancellable>()
    private let networkService = NetworkService()
    
    init() {
        $query
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] query in
                Task {
                    await self?.fetchMovies(query: query)
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchMovies(query: String) async {
        guard !query.isEmpty else {
            self.movies = []
            return
        }
        
        do {
            let movies = try await networkService.fetchMovies(query: query, page: page)
            self.movies = movies
        } catch {
            print(error.localizedDescription)
        }
    }
}

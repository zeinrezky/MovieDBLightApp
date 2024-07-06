//
//  MovieViewModelTests.swift
//  Kipas-kipas_Movie_UIKitTests
//
//  Created by zein rezky chandra on 06/07/24.
//

import XCTest
import Combine
@testable import Kipas_kipas_Movie_UIKit

class MovieViewModelTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable>!
    var viewModel: MovieViewModel!
    var mockService: MockMovieService!
    
    override func setUp() {
        super.setUp()
        cancellables = Set<AnyCancellable>()
        mockService = MockMovieService()
        viewModel = MovieViewModel(movieService: mockService)
    }
    
    override func tearDown() {
        cancellables = nil
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testFetchMovies() {
        let expectation = self.expectation(description: "Movies fetched")
        
        viewModel.getNowPlaying()
        
        viewModel.$movies
            .dropFirst()
            .sink { movies in
                XCTAssertFalse(movies.isEmpty, "Movies should not be empty")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    class MockMovieService: MovieServiceProtocol {
        func searchMovies(query: String) -> AnyPublisher<[Movie], any Error> {
            let movies = [Movie(id: 1, title: "Mock Movie", overview: "Overview", posterPath: "nil", releaseDate: "nil", genreIds: [])]
            return Just(movies)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        func getNowPlaying() -> AnyPublisher<[Movie], Error> {
            let movies = [Movie(id: 1, title: "Mock Movie", overview: "Overview", posterPath: "nil", releaseDate: "nil", genreIds: [])]
            return Just(movies)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        func getMovieCredits(movieId: Int) -> AnyPublisher<[Cast], Error> {
            let movie = [Cast(id: 1, name: "Mock Movie", profilePath: "Overview")]
            return Just(movie)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}

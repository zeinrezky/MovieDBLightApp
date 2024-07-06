//
//  MovieViewModelTests.swift
//  Kipas-kipas_Movie_UIKitTests
//
//  Created by zein rezky chandra on 06/07/24.
//

import XCTest
@testable import Kipas_kipas_Movie_UIKit

final class MovieViewModelTests: XCTestCase {

    var viewModel: MovieViewModel!
    var movieService: MockMovieService!
    
    override func setUp() {
        super.setUp()
        movieService = MockMovieService()
        viewModel = MovieViewModel(movieService: movieService)
    }
    
    override func tearDown() {
        viewModel = nil
        movieService = nil
        super.tearDown()
    }
    
    func testSearchMoviesSuccess() {
        let expectation = self.expectation(description: "Movies fetched successfully")
        
        viewModel.searchMovies(query: "Batman") {
            XCTAssertEqual(self.viewModel.movies.count, 2, "Movies count should be 2")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSearchMoviesFailure() {
        let expectation = self.expectation(description: "Movies fetch failed")
        
        movieService.shouldReturnError = true
        
        viewModel.searchMovies(query: "Batman") {
            XCTAssertEqual(self.viewModel.movies.count, 0, "Movies count should be 0")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

class MockMovieService: MovieServiceProtocol {
    var shouldReturnError = false
    
    func searchMovies(query: String, completion: @escaping ([Movie]?) -> Void) {
        if shouldReturnError {
            completion(nil)
        } else {
            let movies = [
                Movie(id: 1, title: "Movie 1", overview: "Overview 1", posterPath: "/path1.jpg", releaseDate: "2022-01-01", genreIds: [28, 12]),
                Movie(id: 2, title: "Movie 2", overview: "Overview 2", posterPath: "/path2.jpg", releaseDate: "2023-01-01", genreIds: [35, 18])
            ]
            completion(movies)
        }
    }
}

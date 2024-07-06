//
//  Kipas_kipas_Movie_UIKitTests.swift
//  Kipas-kipas_Movie_UIKitTests
//
//  Created by zein rezky chandra on 06/07/24.
//

import XCTest
import Combine
@testable import Kipas_kipas_Movie_UIKit

final class Kipas_kipas_Movie_UIKitTests: XCTestCase {

    var cancellables: Set<AnyCancellable>!
    var movieService: MovieService!
    
    override func setUp() {
        super.setUp()
        cancellables = Set<AnyCancellable>()
        movieService = MovieService()
    }
    
    override func tearDown() {
        cancellables = nil
        movieService = nil
        super.tearDown()
    }
    
    func testFetchMovies() {
        let expectation = self.expectation(description: "Movies fetched")
        
        movieService.getNowPlaying()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Failed to fetch movies: \(error)")
                }
            }, receiveValue: { movies in
                XCTAssertFalse(movies.isEmpty, "Movies should not be empty")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchMovieDetails() {
        let expectation = self.expectation(description: "Movie details fetched")
        
        let movieId = 1 // Use a valid movie ID
        movieService.getMovieCredits(movieId: movieId)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Failed to fetch movie details: \(error)")
                }
            }, receiveValue: { movie in
                XCTAssertNotNil(movie, "Movie should not be nil")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 5, handler: nil)
    }

}

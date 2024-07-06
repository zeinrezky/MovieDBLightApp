//
//  Kipas_kipas_Movie_UIKitTests.swift
//  Kipas-kipas_Movie_UIKitTests
//
//  Created by zein rezky chandra on 06/07/24.
//

import XCTest
@testable import Kipas_kipas_Movie_UIKit

final class Kipas_kipas_Movie_UIKitTests: XCTestCase {

    var movieService: MovieService!
        
    override func setUp() {
        super.setUp()
        movieService = MovieService()
    }
    
    override func tearDown() {
        movieService = nil
        super.tearDown()
    }
    
    func testSearchMoviesSuccess() {
        let expectation = self.expectation(description: "Movies fetched successfully")
        
        movieService.searchMovies(query: "Batman") { movies in
            XCTAssertNotNil(movies, "Movies should not be nil")
            XCTAssertGreaterThan(movies!.count, 0, "Movies count should be greater than 0")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSearchMoviesFailure() {
        let expectation = self.expectation(description: "Movies fetch failed")
        
        // Modify the API key to simulate failure
        let wrongApiKeyMovieService = MovieService()
        wrongApiKeyMovieService.searchMovies(query: "Batman") { movies in
            XCTAssertNil(movies, "Movies should be nil")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

}

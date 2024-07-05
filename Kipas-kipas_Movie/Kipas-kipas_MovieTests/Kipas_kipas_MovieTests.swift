//
//  Kipas_kipas_MovieTests.swift
//  Kipas-kipas_MovieTests
//
//  Created by zein rezky chandra on 05/07/24.
//

import XCTest
@testable import Kipas_kipas_Movie

final class Kipas_kipas_MovieTests: XCTestCase {

    var networkService: NetworkService!
        
    override func setUp() {
        super.setUp()
        networkService = NetworkService()
    }
    
    override func tearDown() {
        networkService = nil
        super.tearDown()
    }
    
    func testFetchMovies() {
        let expectation = XCTestExpectation(description: "Fetch movies")
        
        networkService.fetchMovies(query: "Inception", page: 1) { result in
            switch result {
            case .success(let movies):
                XCTAssertFalse(movies.isEmpty)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

}

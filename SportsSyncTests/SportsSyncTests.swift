//
//  SportsSyncTests.swift
//  SportsSyncTests
//
//  Created by Aya Mostafa on 10/05/2024.
//

import XCTest
@testable import SportsSync

final class SportsSyncTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testfetchDataFromAPI () {
            let myExpectation = expectation(description: "wait api...")
            let url = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=4c8f425c876d47be6be85dc7a9ab9b4928e4e812a4d47f6ecd61163c3da0845f"
            ApiService.shared.fetchData(urlString: url) { (result: Result<[League], Error>) in
                switch result {
                            case.success(let league):
                                XCTAssertEqual(league.count, 865)
                                myExpectation.fulfill()
                            case.failure(let error):
                                XCTFail()
                                print("Error fetching leagues: \(error)")
                            }
            }
            waitForExpectations(timeout: 50)
        }

}

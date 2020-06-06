//
//  PetitionsNetworkRequestor.swift
//  SayTheirNamesTests
//
//  Created by Oliver Binns on 05/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Mocker
import XCTest
@testable import Say_Their_Names

extension NetworkRequestorTests {
    func test_fetchPetitions_makesRequest() {
        guard let apiEndpoint = URL(string: PetitionEnvironment.baseUrlSring) else {
            XCTFail("URL was not valid")
            return
        }

        // Set up mock to return data from the endpoint, and expectation that the request is made
        let makeRequestExpectation = expectation(description: "Request should made")
        var mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.get: Data()])
        mock.completion = {
            makeRequestExpectation.fulfill()
        }
        mock.register()

        // Make request and expect that a result is returned
        let returnRequestExpection = expectation(description: "Request should return")
        sut.fetchPetitions { _ in
            returnRequestExpection.fulfill()
        }

        // Wait for request to be made and returned
        wait(for: [makeRequestExpectation, returnRequestExpection], timeout: 2)
    }
    
    func test_fetchPetitionsPersonName_makesRequest() {
        guard let apiEndpoint = URL(string: PetitionEnvironment.petitionsSearchString) else {
            XCTFail("URL was not valid")
            return
        }

        // Set up mock to return data from the endpoint, and expectation that the request is made
        let makeRequestExpectation = expectation(description: "Request should be made")
        var mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.get: Data()])
        mock.completion = {
            makeRequestExpectation.fulfill()
        }
        mock.register()

        // Make request and expect that a result is returned
        let returnRequestExpection = expectation(description: "Request should return")
        sut.fetchPetitionsByPersonName("george") { _ in
            returnRequestExpection.fulfill()
        }

        // Wait for request to be made and returned
        wait(for: [makeRequestExpectation, returnRequestExpection], timeout: 2)
    }
    
    func test_fetchPetitionsByType_makesRequest() {
        guard let apiEndpoint = URL(string: PetitionEnvironment.petitionsTypeSearchString) else {
            XCTFail("URL was not valid")
            return
        }

        // Set up mock to return data from the endpoint, and expectation that the request is made
        let makeRequestExpectation = expectation(description: "Request should be made")
        var mock = Mock(url: apiEndpoint, dataType: .json, statusCode: 200, data: [.get: Data()])
        mock.completion = {
            makeRequestExpectation.fulfill()
        }
        mock.register()

        // Make request and expect that a result is returned
        let returnRequestExpection = expectation(description: "Request should return")
        sut.fetchPetitionsByType("victim") { _ in
            returnRequestExpection.fulfill()
        }

        // Wait for request to be made and returned
        wait(for: [makeRequestExpectation, returnRequestExpection], timeout: 2)
    }
}

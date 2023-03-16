//
//  DataServiceTests.swift
//  AutomationTestAppTests
//
//  Created by Antoine Dufayet on 15/03/2023.
//

import XCTest
@testable import AutomationTestApp

final class DataServiceTests: XCTestCase {
    var dataService: DataService!
    var urlSessionMock: MockURLSession!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        dataService = nil
        super.tearDown()
    }

    func testGetDataShouldPostFailedCallbackIfError() {
        // Given
        let error: Error? = FakeResponseData.fakeTransportError
        dataService = DataService(urlSession:  MockURLSession(completionHandler: (nil, nil, error)))
        dataService.getData { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.transportError(NSError()))
            case .success(_):
                XCTFail("must have no data")
            }
        }
    }
    func testGetDataShouldPostFailedCallbackIfResponseKO() {
        // Given
        urlSessionMock = MockURLSession(completionHandler: (nil, FakeResponseData.responseKO, nil))
        dataService = DataService(urlSession: urlSessionMock)

        // When
        dataService.getData { result in
            
            //Then
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.serverError(statusCode: 500))
            case .success(_):
                XCTFail("must have no data")
            }
        }
    }
    func testGetDataShouldPostFailedCallbackIfNoData() {
        // Given
        urlSessionMock = MockURLSession(completionHandler: (nil, FakeResponseData.responseOK, nil))
        dataService = DataService(urlSession: urlSessionMock)

        // When
        dataService.getData { result in
            
            // Then
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.noData)
            case .success(_):
                XCTFail("must have no data")
            }
        }
    }
    func testGetDataShouldPostFailedCallbackIfDataHasDecodingError() {
        // Given
        urlSessionMock = MockURLSession(completionHandler: (FakeResponseData.incorrectData, FakeResponseData.responseOK, nil))
        dataService = DataService(urlSession: urlSessionMock)

        // When
        dataService.getData { result in
            
            // Then
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.decodingError(NSError()))
            case .success(_):
                XCTFail("must have no data")
            }
        }
    }
    func testGetDataShouldPostSucessCallbackIfDataIsDecoded() {
        // Given
        urlSessionMock = MockURLSession(completionHandler: (FakeResponseData.correctData, FakeResponseData.responseOK, nil))
        dataService = DataService(urlSession: urlSessionMock)

        // When
        dataService.getData { result in

            // Then
            switch result {
            case .failure(_):
                XCTFail("must have no error")
            case .success(let homeData):
                XCTAssertNotNil(homeData)
            }
        }
    }
}

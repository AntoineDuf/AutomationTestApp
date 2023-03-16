//
//  URLProtocolMock.swift
//  AutomationTestAppTests
//
//  Created by Antoine Dufayet on 15/03/2023.
//

import Foundation
import XCTest
@testable import AutomationTestApp

final class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    func resume() {}
}

final class MockURLSession: URLSessionProtocol {

    var dataTask = MockURLSessionDataTask()
    var completionHandler: (Data?, URLResponse?, Error?)

    init(completionHandler: (Data?, URLResponse?, Error?)) {
        self.completionHandler = completionHandler
    }

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        completionHandler(self.completionHandler.0, self.completionHandler.1, self.completionHandler.2)
        return dataTask
    }
}

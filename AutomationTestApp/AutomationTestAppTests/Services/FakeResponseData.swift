//
//  FakeResponseData.swift
//  AutomationTestAppTests
//
//  Created by Antoine Dufayet on 15/03/2023.
//

import Foundation
@testable import AutomationTestApp

final class FakeResponseData {
    static var correctData: Data? {
        if let url = Bundle.main.url(forResource: "HomeData", withExtension: "json") {
            let data = try? Data(contentsOf: url)
            return data
        }
        return nil
    }
    static var incorrectData: Data? {
        if let url = Bundle.main.url(forResource: "IncorrectData", withExtension: "json") {
            let data = try? Data(contentsOf: url)
            return data
        }
        return nil
    }
    
    static var responseOK: HTTPURLResponse? {
        guard let url = URL(string: "test") else { return nil }
        return HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
    }

    static var responseKO: HTTPURLResponse? {
        guard let url = URL(string: "test") else { return nil }
        return HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)
    }

    static let fakeTransportError = NetworkError.transportError(NSError())
}

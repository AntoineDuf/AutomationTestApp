//
//  DataService.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import Foundation

final class DataService {
    private let urlSession: URLSessionProtocol
    private let decoder = JSONDecoder()

    init(urlSession: URLSessionProtocol = URLSession.init(configuration: .default)) {
        self.urlSession = urlSession
    }

    func getData(completion: @escaping (Result<HomeData, NetworkError>) -> Void) {
        if let url = URL(string: "http://storage42.com/modulotest/data.json") {
            urlSession.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(.transportError(error)))
                    return
                }
                if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    completion(.failure(.serverError(statusCode: response.statusCode)))
                    return
                }
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                do {
                    let homeData = try self.decoder.decode(HomeData.self, from: data)
                    completion(.success(homeData))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }.resume()
        }
    }
}


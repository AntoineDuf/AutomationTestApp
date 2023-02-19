//
//  HomeData.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import Foundation

struct HomeData: Codable {
    let devices: [Device]
    let user: User
}

protocol Deviceable {
    var id: Int { get }
    var deviceName: String { get }
    var productType: String { get }
}

struct Device: Codable {
    let id: Int
    let deviceName: String
    let intensity: Int?
    let mode: String?
    let productType: String
    let position: Int?
    let temperature: Int?
}

struct User: Codable {
    let firstName: String
    let lastName: String
    let address: Address
    let birthDate: Int
}

struct Address: Codable {
    let city: String
    let postalCode: Int
    let street: String
    let streetCode: String
    let country: String
}


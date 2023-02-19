//
//  Light.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import Foundation

struct Light: Deviceable {
    let id: Int
    let deviceName: String
    let productType: String
    var intensity: Int
    var mode: String
}


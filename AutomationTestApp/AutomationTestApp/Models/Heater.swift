//
//  Heater.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import Foundation

final class Heater: Deviceable {
    let id: Int
    let deviceName: String
    let productType: String
    var temperature: Float
    var mode: String

    init(id: Int, deviceName: String, productType: String, temperature: Float, mode: String) {
        self.id = id
        self.deviceName = deviceName
        self.productType = productType
        self.temperature = temperature
        self.mode = mode
    }
}

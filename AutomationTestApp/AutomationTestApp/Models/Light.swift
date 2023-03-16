//
//  Light.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import Foundation

final class Light: Deviceable {
    let id: Int
    let deviceName: String
    let productType: String
    var intensity: Int
    var mode: String

    init(id: Int, deviceName: String, productType: String, intensity: Int, mode: String) {
        self.id = id
        self.deviceName = deviceName
        self.productType = productType
        self.intensity = intensity
        self.mode = mode
    }
}

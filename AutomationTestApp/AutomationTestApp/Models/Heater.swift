//
//  Heater.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import Foundation

struct Heater: Deviceable {
    var id: Int
    var deviceName: String
    var productType: String
    var temperature: Float
    var mode: String
}

//
//  RollerShutter.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

final class RollerShutter: Deviceable {
    let id: Int
    let deviceName: String
    let productType: String
    var position: Int

    init(id: Int, deviceName: String, productType: String, position: Int) {
        self.id = id
        self.deviceName = deviceName
        self.productType = productType
        self.position = position
    }
}

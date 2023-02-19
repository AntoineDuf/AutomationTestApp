//
//  DataAdapter.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import Foundation

final class DataAdapter {

    func lightAdapter(device: Device) -> Light? {
        guard let intensity = device.intensity,
              let mode = device.mode else { return nil }
        return Light(id: device.id, deviceName: device.deviceName, productType: device.productType, intensity: intensity, mode: mode)
    }

    func rollerAdapter(device: Device) -> RollerShutter? {
        guard let position = device.position else { return nil }
        return  RollerShutter(id: device.id, deviceName: device.deviceName, productType: device.productType, position: position)
    }

    func heaterAdapter(device: Device) -> Heater? {
        guard let temperature = device.temperature,
              let mode = device.mode else { return nil }
        return Heater(id: device.id, deviceName: device.deviceName, productType: device.productType, temperature: Float(temperature), mode: mode)
    }
}

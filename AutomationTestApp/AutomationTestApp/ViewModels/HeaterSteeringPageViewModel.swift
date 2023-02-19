//
//  HeaterSteeringPageViewModel.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import Foundation

final class HeaterSteeringPageViewModel {
    //MARK: - Properties
    var coordinator: HeaterSteeringPageCoordinator?
    var heater: Heater

    init(coordinator: HeaterSteeringPageCoordinator? = nil, heater: Heater) {
        self.coordinator = coordinator
        self.heater = heater
    }

    //MARK: - Methods
    func updateMode(isOn: Bool) {
        let mode = isOn ? "ON" : "OFF"
        heater.mode = mode
    }

    func setRoundTemperature(value: Float) -> Float {
        roundf(value / 0.5) * 0.5
    }

    func updateTemperature(temperature: Float) {
        heater.temperature = temperature
    }

    func temperatureStringAdapter(isOn: Bool, temperature: Float) -> String {
        let string = isOn ? NSLocalizedString("onAt", comment: "") + " \(temperature)°" : NSLocalizedString("off", comment: "")
        return string
    }
}

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
    var reloadUIHandler: () -> Void = {}
    private(set) var heater: Heater

    var heaterIsOn: Bool {
        heater.mode == "ON" ? true : false
    }
    var temperatureString: String {
        heaterIsOn ? NSLocalizedString("onAt", comment: "") + " \(heater.temperature)°" : NSLocalizedString("off", comment: "")
    }

    init(coordinator: HeaterSteeringPageCoordinator? = nil, heater: Heater) {
        self.coordinator = coordinator
        self.heater = heater
    }

    //MARK: - Methods
    func updateMode(isOn: Bool) {
        let mode = isOn ? "ON" : "OFF"
        heater.mode = mode
        reloadUIHandler()
    }

    func updateTemperature(value: Float) {
        heater.mode = "ON"
        heater.temperature = roundf(value / 0.5) * 0.5
        reloadUIHandler()
    }
}

//
//  LightSteeringPageViewModel.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import Foundation

final class LightSteeringPageViewModel {
    //MARK: - Properties
    var coordinator: LightSteeringPageCoordinator?
    var light: Light
    var lightIsOn: Bool {
        light.mode == "ON" ? true : false
    }

    init(coordinator: LightSteeringPageCoordinator? = nil, light: Light) {
        self.light = light
    }

    //MARK: - Methods
    func updateMode(isOn: Bool) {
        let mode = isOn ? "ON" : "OFF"
        light.mode = mode
    }

    func deviceIntensityStringAdapter(position: Int) -> String {
        if light.mode == "OFF" {
            return NSLocalizedString("off", comment: "")
        } else {
            if position == 100 {
                return NSLocalizedString("on", comment: "")
            }
            return NSLocalizedString("lightingAt", comment: "") + " \(position)%"
        }
    }
}


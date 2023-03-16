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
    var reloadUIHandler: () -> Void = {}
    private(set) var light: Light

    var lightIsOn: Bool {
        light.mode == "ON" ? true : false
    }
    var deviceIntensityString: String {
        lightIsOn ? NSLocalizedString("lightingAt", comment: "") + " \(light.intensity)%" : NSLocalizedString("off", comment: "")
    }

    init(coordinator: LightSteeringPageCoordinator? = nil, light: Light) {
        self.light = light
    }

    //MARK: - Methods
    func updateMode(isOn: Bool) {
        let mode = isOn ? "ON" : "OFF"
        light.mode = mode
        reloadUIHandler()
    }
    
    func updateIntensity(value: Float) {
        light.mode = "ON"
        light.intensity = Int(value)
        reloadUIHandler()
    }
}


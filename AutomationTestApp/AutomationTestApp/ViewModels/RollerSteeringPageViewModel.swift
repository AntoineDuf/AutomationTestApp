//
//  RollerSteeringPageViewModel.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import Foundation

final class RollerSteeringPageViewModel {
    //MARK: - Properties
    var coordinator: RollerSteeringPageCoordinator?
    var reloadUIHandler: () -> Void = {}
    var rollerShutter: RollerShutter {
        didSet {
            reloadUIHandler()
        }
    }

    init(coordinator: RollerSteeringPageCoordinator? = nil, rollerShutter: RollerShutter) {
        self.coordinator = coordinator
        self.rollerShutter = rollerShutter
    }

    //MARK: - Methods
    func updatePosition(value: Float) {
        rollerShutter.position = Int(value)
    }

    func devicePositionStringAdapter() -> String {
        switch rollerShutter.position {
        case 0:
            return NSLocalizedString("closed", comment: "")
        case 100:
            return NSLocalizedString("opened", comment: "")
        default:
            return NSLocalizedString("openedAt", comment: "") + " \(rollerShutter.position)%"
        }
    }
}

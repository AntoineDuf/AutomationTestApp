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
    var rollerShutter: RollerShutter

    init(coordinator: RollerSteeringPageCoordinator? = nil, rollerShutter: RollerShutter) {
        self.coordinator = coordinator
        self.rollerShutter = rollerShutter
    }

    //MARK: - Methods
    func devicePositionStringAdapter(position: Int) -> String {
        switch position {
        case 0:
            return NSLocalizedString("closed", comment: "")
        case 100:
            return NSLocalizedString("opened", comment: "")
        default:
            return NSLocalizedString("openedAt", comment: "") + " \(position)%"
        }
    }
}

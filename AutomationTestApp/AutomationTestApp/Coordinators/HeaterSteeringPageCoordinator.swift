//
//  HeaterSteeringPageCoordinator.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

final class HeaterSteeringPageCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let heater: Heater
    
    var parentCoordinator : HomeDeviceListCoordinator?

    init(navigationController: UINavigationController, heater: Heater) {
        self.navigationController = navigationController
        self.heater = heater
    }

    func start() {
        let heaterSteeringPageViewController = HeaterSteeringPageViewController()
        let heaterSteeringPageViewModel = HeaterSteeringPageViewModel(coordinator: self, heater: heater)
        heaterSteeringPageViewController.viewModel = heaterSteeringPageViewModel

        navigationController.pushViewController(heaterSteeringPageViewController, animated: false)
    }
    
    func didFinishLightSteeringPage() {
        parentCoordinator?.childDidFinish(self)
    }
}

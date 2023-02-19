//
//  LightSteeringPageCoordinator.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

final class LightSteeringPageCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let light: Light
    
    var parentCoordinator : HomeDeviceListCoordinator?

    init(navigationController: UINavigationController, light: Light) {
        self.navigationController = navigationController
        self.light = light
    }

    func start() {
        let lightSteeringPageViewController = LightSteeringPageViewController()
        let lightSteeringPageViewModel = LightSteeringPageViewModel(light: light)
        lightSteeringPageViewController.viewModel = lightSteeringPageViewModel
        navigationController.pushViewController(lightSteeringPageViewController, animated: false)
    }
    
    func didFinishLightSteeringPage() {
        parentCoordinator?.childDidFinish(self)
    }
}


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
    private let delegate: UIViewController
    
    var parentCoordinator : HomeDeviceListCoordinator?

    init(navigationController: UINavigationController, light: Light, delegate: UIViewController) {
        self.navigationController = navigationController
        self.light = light
        self.delegate = delegate
    }

    func start() {
        let lightSteeringPageViewController = LightSteeringPageViewController()
        let lightSteeringPageViewModel = LightSteeringPageViewModel(coordinator: self, light: light)
        lightSteeringPageViewController.viewModel = lightSteeringPageViewModel
        lightSteeringPageViewController.delegate = delegate as? any LightSteeringDelegate
        navigationController.pushViewController(lightSteeringPageViewController, animated: false)
    }
    
    func didFinishLightSteeringPage() {
        parentCoordinator?.childDidFinish(self)
    }
}


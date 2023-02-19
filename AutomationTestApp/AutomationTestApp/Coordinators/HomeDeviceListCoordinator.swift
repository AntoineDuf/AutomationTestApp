//
//  HomeDeviceListCoordinator.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

final class HomeDeviceListCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        let homeDeviceListViewController = HomeDeviceListViewController()
        let homeDeviceListViewModel = HomeDeviceListViewModel()
        homeDeviceListViewModel.coordinator = self
        homeDeviceListViewController.viewModel = homeDeviceListViewModel
        navigationController.setViewControllers([homeDeviceListViewController], animated: false)
    }

    func startLightSteeringPage(light: Light) {
        let lightSteeringPageCoordinator = LightSteeringPageCoordinator(navigationController: navigationController, light: light)
        childCoordinators.append(lightSteeringPageCoordinator)
        lightSteeringPageCoordinator.parentCoordinator = self
        lightSteeringPageCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}

//
//  HomeDeviceListCoordinator.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

protocol BackToPreviousViewControllerDelegate {
    func childDidFinish(_ childCoordinator: Coordinator)
}

protocol GoToNextControllersDelegate {
    func startLightSteeringPage(light: Light, delegate: UIViewController)
    func startRollerSteeringPage(rollerShutter: RollerShutter, delegate: UIViewController)
    func startHeaterSteeringPage(heater: Heater, delegate: UIViewController)
}

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
        homeDeviceListViewModel.coordinatorDelegate = self
        homeDeviceListViewController.viewModel = homeDeviceListViewModel
        navigationController.setViewControllers([homeDeviceListViewController], animated: false)
    }
}

extension HomeDeviceListCoordinator: BackToPreviousViewControllerDelegate {
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}

extension HomeDeviceListCoordinator: GoToNextControllersDelegate {
    func startLightSteeringPage(light: Light, delegate: UIViewController) {
        let lightSteeringPageCoordinator = LightSteeringPageCoordinator(navigationController: navigationController, light: light, delegate: delegate)
        childCoordinators.append(lightSteeringPageCoordinator)
        lightSteeringPageCoordinator.parentCoordinatorDelegate = self
        lightSteeringPageCoordinator.start()
    }

    func startRollerSteeringPage(rollerShutter: RollerShutter, delegate: UIViewController) {
        let rollerSteeringPageCoordinator = RollerSteeringPageCoordinator(navigationController: navigationController, rollerShutter: rollerShutter, delegate: delegate)
        childCoordinators.append(rollerSteeringPageCoordinator)
        rollerSteeringPageCoordinator.parentCoordinatorDelegate = self
        rollerSteeringPageCoordinator.start()
    }

    func startHeaterSteeringPage(heater: Heater, delegate: UIViewController) {
        let heaterSteeringPageCoordinator = HeaterSteeringPageCoordinator(navigationController: navigationController, heater: heater, delegate: delegate)
        childCoordinators.append(heaterSteeringPageCoordinator)
        heaterSteeringPageCoordinator.parentCoordinatorDelegate = self
        heaterSteeringPageCoordinator.start()
    }
}

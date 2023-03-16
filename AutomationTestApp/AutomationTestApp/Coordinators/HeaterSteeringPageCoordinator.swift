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
    private let delegate: UIViewController
    
    var parentCoordinatorDelegate: BackToPreviousViewControllerDelegate?

    init(navigationController: UINavigationController, heater: Heater, delegate: UIViewController) {
        self.navigationController = navigationController
        self.heater = heater
        self.delegate = delegate
    }

    func start() {
        let heaterSteeringPageViewController = HeaterSteeringPageViewController()
        let heaterSteeringPageViewModel = HeaterSteeringPageViewModel(coordinator: self, heater: heater)
        heaterSteeringPageViewController.viewModel = heaterSteeringPageViewModel
        heaterSteeringPageViewController.delegate = delegate as? any HomeControllerDelegate
        navigationController.pushViewController(heaterSteeringPageViewController, animated: false)
    }
    
    func didFinishLightSteeringPage() {
        parentCoordinatorDelegate?.childDidFinish(self)
    }
}


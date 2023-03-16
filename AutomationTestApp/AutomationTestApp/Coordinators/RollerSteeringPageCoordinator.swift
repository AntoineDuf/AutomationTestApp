//
//  RollerSteeringPageCoordinator.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

final class RollerSteeringPageCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let rollerShutter: RollerShutter
    private let delegate: UIViewController

    var parentCoordinatorDelegate: BackToPreviousViewControllerDelegate?

    init(navigationController: UINavigationController, rollerShutter: RollerShutter, delegate: UIViewController) {
        self.navigationController = navigationController
        self.rollerShutter = rollerShutter
        self.delegate = delegate
    }

    func start() {
        let rollerSteeringPageViewController = RollerSteeringPageViewController()
        let rollerSteeringPageViewModel = RollerSteeringPageViewModel(coordinator: self, rollerShutter: rollerShutter)
        rollerSteeringPageViewController.viewModel = rollerSteeringPageViewModel
        rollerSteeringPageViewController.delegate = delegate as? any HomeControllerDelegate
        navigationController.pushViewController(rollerSteeringPageViewController, animated: false)
    }

    func didFinishLightSteeringPage() {
        parentCoordinatorDelegate?.childDidFinish(self)
    }
}


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
        homeDeviceListViewController.viewModel = homeDeviceListViewModel
        navigationController.setViewControllers([homeDeviceListViewController], animated: false)
        
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}

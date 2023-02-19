//
//  HomeDeviceListViewModel.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import Foundation

final class HomeDeviceListViewModel {

    //MARK: - Properties
    var user: User?
    let dataService: DataService
    var coordinator: HomeDeviceListCoordinator?
    var reloadTableViewHandler: () -> Void = {}
    var goToNextControllerHandler: () -> Void = {}
    var homeDevices: [[Deviceable]] {
        didSet {
            reloadTableViewHandler()
        }
    }
    var selectedDevice: Deviceable? {
        didSet {
            goToNextControllerHandler()
        }
    }

    init(homeDevices: [[Deviceable]] = [], dataService: DataService = .init()) {
        self.homeDevices = homeDevices
        self.dataService = dataService
    }

    //MARK: - Methods
    func loadData() {
        user = dataService.getUser()
        homeDevices = dataService.getDevice() ?? []
    }

    func sectionCount() -> Int {
        homeDevices.count
    }

    func rowCount(section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return homeDevices[section - 1].count
    }

    func didSelectDevice(section: Int, indexPath: Int) {
        selectedDevice = homeDevices[section][indexPath]
    }
}

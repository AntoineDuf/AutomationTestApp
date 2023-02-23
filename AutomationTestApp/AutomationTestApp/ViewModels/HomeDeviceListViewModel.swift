//
//  HomeDeviceListViewModel.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import Foundation

final class HomeDeviceListViewModel {

    //MARK: - Properties
    private(set) var user: User?
    let dataService: DataService
    var coordinator: HomeDeviceListCoordinator?
    var reloadTableViewHandler: () -> Void = {}
    var goToNextControllerHandler: () -> Void = {}
    private(set) var homeDevices: [[Deviceable]] {
        didSet {
            reloadTableViewHandler()
        }
    }
    private(set) var selectedDevice: Deviceable? {
        didSet {
            goToNextControllerHandler()
        }
    }

    var sectionCount: Int {
        homeDevices.count
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

    func rowCount(section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return homeDevices[section - 1].count
    }

    func didSelectDevice(section: Int, indexPath: Int) {
        selectedDevice = homeDevices[section][indexPath]
    }

    func updateDevice(device: Deviceable) {
        switch device {
        case is Light:
            if let index = homeDevices[0].firstIndex(where: {$0.id == device.id}) {
                   homeDevices[0][index] = device
            }
        case is RollerShutter:
            if let index = homeDevices[1].firstIndex(where: {$0.id == device.id}) {
                   homeDevices[1][index] = device
            }
        case is Heater:
            if let index = homeDevices[2].firstIndex(where: {$0.id == device.id}) {
                   homeDevices[2][index] = device
            }
        default:
            return
        }
    }
}

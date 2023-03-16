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
    var coordinatorDelegate: GoToNextControllersDelegate?
    private let dataAdapter = DataAdapter()
    var reloadTableViewHandler: () -> Void = {}
    var goToNextControllerHandler: () -> Void = {}
    private(set) var lights = [Light]()
    private(set) var rollers = [RollerShutter]()
    private(set) var heaters = [Heater]()

    private(set) var selectedDevice: Deviceable? {
        didSet {
            goToNextControllerHandler()
        }
    }

    var sectionCount: Int {
        4
    }

    init(dataService: DataService = DataService()) {
        self.dataService = dataService
    }

    //MARK: - Methods
    func loadData() {
        dataService.getData { result in
            switch result {
            case .success(let homeData):
                self.adapteHomeData(homeData: homeData)
            case .failure(let error):
                // TODO manage the display of the error
                print(error)
                self.reloadTableViewHandler()
            }
        }
    }
        

    func rowCount(section: Int) -> Int {
        switch section {
        case 0:
            return user != nil ? 1 : 0
        case 1:
            return lights.count
        case 2:
            return rollers.count
        case 3:
            return heaters.count
        default:
            return 0
        }
    }

    func didSelectDevice(section: Int, indexPath: Int) {
        switch section {
        case 1:
            selectedDevice = lights[indexPath]
        case 2:
            selectedDevice = rollers[indexPath]
        case 3:
            selectedDevice = heaters[indexPath]
        default:
            return
        }
    }

    private func adapteHomeData(homeData: HomeData) {
        user = homeData.user
        for device in homeData.devices {
            switch device.productType {
            case "Light":
                if let light = dataAdapter.lightAdapter(device: device) {
                    lights.append(light)
                }
            case "RollerShutter":
                if let roller = dataAdapter.rollerAdapter(device: device) {
                    rollers.append(roller)
                }
            case "Heater":
                if let heater = dataAdapter.heaterAdapter(device: device) {
                    heaters.append(heater)
                }
            default:
                return
            }
        }
        reloadTableViewHandler()
    }
}

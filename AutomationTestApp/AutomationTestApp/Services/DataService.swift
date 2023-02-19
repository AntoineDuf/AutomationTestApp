//
//  DataService.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import Foundation

final class DataService {
    let deviceAdapter = DataAdapter()
    let decoder = JSONDecoder()
    
    func getData() -> HomeData? {
        guard
            let url = Bundle.main.url(forResource: "HomeData", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let homeData = try? decoder.decode(HomeData.self, from: data)
        else {
            return nil
        }
        return homeData
    }
    
    
    func getUser() -> User? {
        if let homeData = getData() {
            return homeData.user
        }
        return nil
    }
    
    func getDevice() -> [[Deviceable]]? {
        if let homeData = getData() {
            var lights = [Light]()
            var rollers = [RollerShutter]()
            var heaters = [Heater]()
            for device in homeData.devices {
                switch device.productType {
                case "Light":
                    if let light = deviceAdapter.lightAdapter(device: device) {
                        lights.append(light)
                    }
                case "RollerShutter":
                    if let roller = deviceAdapter.rollerAdapter(device: device) {
                        rollers.append(roller)
                    }
                case "Heater":
                    if let heater = deviceAdapter.heaterAdapter(device: device) {
                        heaters.append(heater)
                    }
                default:
                    return nil
                }
            }
            var homeDevice = [[Deviceable]]()
            homeDevice.append(lights)
            homeDevice.append(rollers)
            homeDevice.append(heaters)
            return homeDevice
        }
        return nil
    }
}


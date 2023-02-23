//
//  HomeDeviceListViewModelTests.swift
//  AutomationTestAppTests
//
//  Created by Antoine Dufayet on 23/02/2023.
//

import XCTest
@testable import AutomationTestApp

final class HomeDeviceListViewModelTests: XCTestCase {
    var viewModel: HomeDeviceListViewModel!
    var dataService: DataService!

    override func setUp() {
        super.setUp()
        viewModelInstantiation()
    }

    override func tearDown() {
        dataService = nil
        viewModel = nil
        super.tearDown()
    }
    
    private func viewModelInstantiation() {
        dataService = DataService()
        viewModel = HomeDeviceListViewModel(dataService: dataService)
    }
    
    func testHomePageDidLoad() {
        
        // Given viewController has been instantiate.
        let expectation = self.expectation(description: "test")
        viewModel.reloadTableViewHandler = {
            
            // Then User and HomeDevices properties must contain object.
            XCTAssertNotNil(self.viewModel.user)
            XCTAssertEqual(self.viewModel.homeDevices.count, 3)
            expectation.fulfill()
        }
        
        // When LoadData method is call
        viewModel.loadData()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testHomePageDidLoadWithErrorLoadData() {
        
        // Given viewController has been instantiate.
        viewModel = HomeDeviceListViewModel(dataService: DataService(ressourcePath: "WrongFilePath"))
        let expectation = self.expectation(description: "test")
        viewModel.reloadTableViewHandler = {
            
            // Then User and HomeDevices properties must contain object.
            XCTAssertNil(self.viewModel.user)
            XCTAssertEqual(self.viewModel.homeDevices.count, 0)
            expectation.fulfill()
        }
        
        // When LoadData method is call
        viewModel.loadData()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testTableViewLoading() {
        // Given viewController has been instantiate.
        let expectation = self.expectation(description: "test")
        viewModel.reloadTableViewHandler = {
            
            // Then sectionCount and rowCount methods must return proper Int.
            XCTAssertEqual(self.viewModel.sectionCount, 3)
            XCTAssertEqual(self.viewModel.rowCount(section: 0), 1)
            XCTAssertEqual(self.viewModel.rowCount(section: 1), 4)
            XCTAssertEqual(self.viewModel.rowCount(section: 2), 4)
            XCTAssertEqual(self.viewModel.rowCount(section: 3), 4)
            expectation.fulfill()
        }
        
        // When LoadData method is call
        viewModel.loadData()
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testUserSelectADevice() {
        // Given viewController has been instantiate and devices are loaded.
        viewModel.loadData()
        
        let expectation = self.expectation(description: "test")
        viewModel.goToNextControllerHandler = {
            
            // Then selectedDevice property is not nil.
            XCTAssertNotNil(self.viewModel.selectedDevice)
            expectation.fulfill()
        }
        
        // When user select a device.
        viewModel.didSelectDevice(section: 1, indexPath: 0)
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testUserUpdateDeviceOnLightSteeringPage() {
        // Given viewController has been instantiate and devices are loaded.
        viewModel.loadData()
        let light = viewModel.homeDevices[0].first as! Light
        XCTAssertEqual(light.intensity, 50)
        // When user update a light on lightSteeringPage
        viewModel.updateDevice(device: Light(id: 1, deviceName: "Lampe - Cuisine", productType: "Light", intensity: 10, mode: "ON"))
        
        // Then light must be update in homeDevice.
        let lightUpdated = viewModel.homeDevices[0].first as! Light
        XCTAssertEqual(lightUpdated.intensity, 10)
    }

    func testUserUpdateDeviceOnRollerSteeringPage() {
        // Given viewController has been instantiate and devices are loaded.
        viewModel.loadData()
        let roller = viewModel.homeDevices[1].first as! RollerShutter
        XCTAssertEqual(roller.position, 70)

        // When user update a roller on rollerSteeringPage
        viewModel.updateDevice(device: RollerShutter(id: 2, deviceName: "Volet roulant - Salon", productType: "RollerShutter", position: 100))
        
        // Then roller must be update in homeDevice.
        let rollerUpdated = viewModel.homeDevices[1].first as! RollerShutter
        XCTAssertEqual(rollerUpdated.position, 100)
    }

    func testUserUpdateDeviceOnHeaterSteeringPage() {
        // Given viewController has been instantiate and devices are loaded.
        viewModel.loadData()
        let heater = viewModel.homeDevices[2].first as! Heater
        XCTAssertEqual(heater.temperature, 20)

        // When user update a roller on heaterSteeringPage
        viewModel.updateDevice(device: Heater(id: 3, deviceName: "Radiateur - Chambre", productType: "Heater", temperature: 20, mode: "ON"))
        
        // Then heater must be update in homeDevice.
        let heaterUpdated = viewModel.homeDevices[2].first as! Heater
        XCTAssertEqual(heaterUpdated.mode, "ON")
    }
}

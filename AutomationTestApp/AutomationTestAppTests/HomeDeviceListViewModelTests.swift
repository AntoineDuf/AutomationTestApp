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
        viewModel = HomeDeviceListViewModel(dataService: DataService(urlSession: MockURLSession(completionHandler: (FakeResponseData.correctData, FakeResponseData.responseOK, nil))))
    }
    func testHomePageDidLoad() {
        // Given viewController has been instantiate.
        let expectation = self.expectation(description: "test")
        viewModel.reloadTableViewHandler = {
            
            // Then User and HomeDevices properties must contain object.
            XCTAssertNotNil(self.viewModel.user)
            XCTAssertEqual(self.viewModel.lights.count, 4)
            XCTAssertEqual(self.viewModel.rollers.count, 4)
            XCTAssertEqual(self.viewModel.heaters.count, 4)
            expectation.fulfill()
        }
        
        // When LoadData method is call
        viewModel.loadData()
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testHomePageDidLoadWithErrorLoadData() {

        // Given viewController has been instantiate with failed network request.
        viewModel = HomeDeviceListViewModel(dataService: DataService(urlSession: MockURLSession(completionHandler: (nil, FakeResponseData.responseKO, nil))))
        let expectation = self.expectation(description: "test")
        viewModel.reloadTableViewHandler = {

            // Then User and HomeDevices properties must be empty.
            XCTAssertNil(self.viewModel.user)
            XCTAssertEqual(self.viewModel.lights.count, 0)
            XCTAssertEqual(self.viewModel.heaters.count, 0)
            XCTAssertEqual(self.viewModel.rollers.count, 0)
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
            XCTAssertEqual(self.viewModel.sectionCount, 4)
            XCTAssertEqual(self.viewModel.rowCount(section: 0), 1)
            XCTAssertEqual(self.viewModel.rowCount(section: 1), 4)
            XCTAssertEqual(self.viewModel.rowCount(section: 2), 4)
            XCTAssertEqual(self.viewModel.rowCount(section: 3), 4)
            XCTAssertEqual(self.viewModel.rowCount(section: 4), 0)
            expectation.fulfill()
        }

        // When LoadData method is call
        viewModel.loadData()
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testUserSelectALight() {
        // Given viewController has been instantiate and devices are loaded.
        viewModel.loadData()

        let expectation = self.expectation(description: "test")
        viewModel.goToNextControllerHandler = {

            // Then selectedDevice property is not nil and must be a Light object.
            XCTAssertNotNil(self.viewModel.selectedDevice)
            XCTAssert(self.viewModel.selectedDevice is Light)
            expectation.fulfill()
        }

        // When user select a light device.
        viewModel.didSelectDevice(section: 1, indexPath: 0)
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testUserSelectARoller() {
        // Given viewController has been instantiate and devices are loaded.
        viewModel.loadData()

        let expectation = self.expectation(description: "test")
        viewModel.goToNextControllerHandler = {

            // Then selectedDevice property is not nil and must be a RollerShutter object.
            XCTAssertNotNil(self.viewModel.selectedDevice)
            XCTAssert(self.viewModel.selectedDevice is RollerShutter)
            expectation.fulfill()
        }

        // When user select a device.
        viewModel.didSelectDevice(section: 2, indexPath: 0)
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testUserSelectAHeater() {
        // Given viewController has been instantiate and devices are loaded.
        viewModel.loadData()

        let expectation = self.expectation(description: "test")
        viewModel.goToNextControllerHandler = {

            // Then selectedDevice property is not nil and must be a Heater object.
            XCTAssertNotNil(self.viewModel.selectedDevice)
            XCTAssert(self.viewModel.selectedDevice is Heater)
            expectation.fulfill()
        }

        // When user select a device.
        viewModel.didSelectDevice(section: 3, indexPath: 0)
        waitForExpectations(timeout: 1, handler: nil)
    }
}

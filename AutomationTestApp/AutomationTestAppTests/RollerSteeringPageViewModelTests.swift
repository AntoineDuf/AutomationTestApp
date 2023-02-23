//
//  RollerSteeringPageViewModelTests.swift
//  AutomationTestAppTests
//
//  Created by Antoine Dufayet on 23/02/2023.
//

import XCTest
@testable import AutomationTestApp

final class RollerSteeringPageViewModelTests: XCTestCase {
    var viewModel: RollerSteeringPageViewModel!


    override func setUp() {
        super.setUp()
        viewModelInstantiation()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    private func viewModelInstantiation() {
        let roller = RollerShutter(id: 1, deviceName: "Lampe - Cuisine", productType: "Light", position: 48)
        viewModel = RollerSteeringPageViewModel(rollerShutter: roller)
    }

    func testRollerSteeringPageDidLoad() {
        // Given heaterSteeringPage did Load with roller at position 48.
        // When devicePositionStringAdapter property are call
        // Then is must return proper String.
        XCTAssertEqual(viewModel.devicePositionStringAdapter, "ouvert à 48%")
    }

    func testUserUseSliderToCloseRoller() {
        // Given heaterSteeringPage did Load with roller at position 48.
        // When user use slider to close roller.
        viewModel.updatePosition(value: 0)
        // Then is must return proper String and roller position property must be update.
        XCTAssertEqual(viewModel.devicePositionStringAdapter, "fermé")
        XCTAssertEqual(viewModel.rollerShutter.position, 0)
    }

    func testUserUseSliderToOpenRoller() {
        // Given heaterSteeringPage did Load with roller at position 48.
        // When user use slider to close roller.
        viewModel.updatePosition(value: 100)
        // Then is must return proper String and roller position property must be update.
        XCTAssertEqual(viewModel.devicePositionStringAdapter, "ouvert")
        XCTAssertEqual(viewModel.rollerShutter.position, 100)
    }
}

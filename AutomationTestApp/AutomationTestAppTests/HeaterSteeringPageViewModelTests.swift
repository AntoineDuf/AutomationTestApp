//
//  HeaterSteeringPageViewModelTests.swift
//  AutomationTestAppTests
//
//  Created by Antoine Dufayet on 23/02/2023.
//

import XCTest
@testable import AutomationTestApp

final class HeaterSteeringPageViewModelTests: XCTestCase {
    var viewModel: HeaterSteeringPageViewModel!

    override func setUp() {
        super.setUp()
        viewModelInstantiation()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    private func viewModelInstantiation() {
        let heater = Heater(id: 3, deviceName: "Radiateur - Chambre", productType: "Heater", temperature: 19, mode: "ON")
        viewModel = HeaterSteeringPageViewModel(heater: heater)
    }
    
    func testLightSteeringPageDidLoadONLight() {
        // Given heaterSteeringPage did Load with ON heater
        // When heaterIsOn and temperatureString properties are call
        // Then is must return proper Bool and String.
        XCTAssertEqual(viewModel.heaterIsOn, true)
        XCTAssertEqual(viewModel.temperatureString, "ON à 19.0°")
    }

    func testLightSteeringPageDidLoadOFFLight() {
        // Given heaterSteeringPage did Load with ON heater
        let heater = Heater(id: 3, deviceName: "Radiateur - Chambre", productType: "Heater", temperature: 19, mode: "OFF")
        viewModel = HeaterSteeringPageViewModel(heater: heater)
        // When heaterIsOn and temperatureString properties are call
        // Then is must return proper Bool and String.
        XCTAssertEqual(viewModel.heaterIsOn, false)
        XCTAssertEqual(viewModel.temperatureString, "OFF")
    }

    func testUserUseSwitchButtonONLight() {
        // Given heaterSteeringPage did Load with ON heater

        // When user use switchButton to turn OFF the heater.
        viewModel.updateMode(isOn: false)
        
        // Then mode property on heater object must be OFF
        XCTAssertEqual(viewModel.heater.mode, "OFF")
    }

    func testUserUseSwitchButtonOFFLight() {
        // Given heaterSteeringPage did Load with OFF heater
        let heater = Heater(id: 3, deviceName: "Radiateur - Chambre", productType: "Heater", temperature: 19, mode: "OFF")
        viewModel = HeaterSteeringPageViewModel(heater: heater)

        // When user use switchButton to turn ON the heater.
        viewModel.updateMode(isOn: true)
        
        // Then mode property on heater object must be OFF
        XCTAssertEqual(viewModel.heater.mode, "ON")
    }


    func testUserUseSlider() {
        // Given heaterSteeringPage did Load with intensity heater at 19.
        
        // When user use switchButton to turn OFF the light.
        viewModel.updateTemperature(value: 25.40)
        
        // Then mode property on light object must be OFF
        XCTAssertEqual(viewModel.heater.temperature, 25.5)

    }
}

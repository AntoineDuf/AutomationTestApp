//
//  LightSteeringPageViewModelTests.swift
//  AutomationTestAppTests
//
//  Created by Antoine Dufayet on 23/02/2023.
//

import XCTest
@testable import AutomationTestApp

final class LightSteeringPageViewModelTests: XCTestCase {
    var viewModel: LightSteeringPageViewModel!

    override func setUp() {
        super.setUp()
        viewModelInstantiation()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    private func viewModelInstantiation() {
        let light = Light(id: 1, deviceName: "Lampe - Cuisine", productType: "Light", intensity: 50, mode: "ON")
        viewModel = LightSteeringPageViewModel(light: light)
    }
    
    func testLightSteeringPageDidLoadONLight() {
        // Given lightSteeringPage did Load with ON light
        // When lightIsOn and deviceIntensityString properties are call
        // Then is must return proper Bool and String.
        XCTAssertEqual(viewModel.lightIsOn, true)
        XCTAssertEqual(viewModel.deviceIntensityString, "éclaire à 50%")
    }

    func testLightSteeringPageDidLoadOFFLight() {
        // Given lightSteeringPage did Load with ON light
        let light = Light(id: 1, deviceName: "Lampe - Cuisine", productType: "Light", intensity: 50, mode: "OFF")
        viewModel = LightSteeringPageViewModel(light: light)
        // When lightIsOn and deviceIntensityString properties are call
        // Then is must return proper Bool and String.
        XCTAssertEqual(viewModel.lightIsOn, false)
        XCTAssertEqual(viewModel.light.mode, "OFF")
        XCTAssertEqual(viewModel.deviceIntensityString, "OFF")
    }

    func testUserUseSwitchButtonONLight() {
        // Given lightSteeringPage did Load with ON light

        // When user use switchButton to turn OFF the light.
        viewModel.updateMode(isOn: false)
        
        // Then mode property on light object must be OFF
        XCTAssertEqual(viewModel.light.mode, "OFF")
    }

    func testUserUseSwitchButtonOFFLight() {
        // Given lightSteeringPage did Load with OFF light
        let light = Light(id: 1, deviceName: "Lampe - Cuisine", productType: "Light", intensity: 50, mode: "OFF")
        viewModel = LightSteeringPageViewModel(light: light)

        // When user use switchButton to turn ON the light.
        viewModel.updateMode(isOn: true)
        
        // Then mode property on light object must be OFF
        XCTAssertEqual(viewModel.light.mode, "ON")
    }


    func testUserUseSlider() {
        // Given lightSteeringPage did Load with intensity light at 50.
        
        // When user use switchButton to turn OFF the light.
        viewModel.updateIntensity(value: 25.40)
        
        // Then mode property on light object must be OFF
        XCTAssertEqual(self.viewModel.light.intensity, 25)
    }
}

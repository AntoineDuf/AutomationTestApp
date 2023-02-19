//
//  HeaterSteeringPageViewController.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

protocol HeaterSteeringDelegate {
    func updateData(heater: Heater)
}

class HeaterSteeringPageViewController: UIViewController {
    
    //MARK: - Properties
    var delegate: HeaterSteeringDelegate!
    var viewModel: HeaterSteeringPageViewModel!
    var steeringView: HeaterSteeringPageView!

    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        setup()
        setControlEvent()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate.updateData(heater: viewModel.heater)
        viewModel.coordinator?.didFinishLightSteeringPage()
    }

    private func setSwitchAndTemperatureLabel() {
            switch self.viewModel.heater.mode {
            case "OFF":
                self.steeringView.temperatureLabel.text = NSLocalizedString("off", comment: "")
                self.steeringView.switchButton.setOn(false, animated: false)
            default:
                self.steeringView.temperatureLabel.text = NSLocalizedString("onAt", comment: "") + " \(self.viewModel.heater.temperature)°"
                self.steeringView.switchButton.setOn(true, animated: false)
            }
    }

    @objc func updatePositionLabel(sender: UISlider!) {
        let temperature = viewModel.setRoundTemperature(value: sender.value)
        self.viewModel.updateTemperature(temperature: temperature)
        DispatchQueue.main.async {
            self.steeringView.temperatureLabel.text = self.viewModel.temperatureStringAdapter(isOn: self.steeringView.switchButton.isOn, temperature: temperature)
        }
    }

    @objc func switchUpdated(sender: UISwitch!) {
        self.viewModel.updateMode(isOn: sender.isOn)
        let temperature = viewModel.setRoundTemperature(value: steeringView.rollerSlider.value)
        DispatchQueue.main.async {
            self.steeringView.temperatureLabel.text = self.viewModel.temperatureStringAdapter(isOn: self.steeringView.switchButton.isOn, temperature: temperature)
        }
    }
}

//MARK: - UserInteraction Event
private extension HeaterSteeringPageViewController {
    func setControlEvent() {
        steeringView.rollerSlider.addTarget(self, action: #selector(updatePositionLabel), for: .valueChanged)
        steeringView.switchButton.addTarget(self, action: #selector(switchUpdated), for: .valueChanged)
    }
}

// MARK: - Setup
private extension HeaterSteeringPageViewController {
    func setup() {
        view.backgroundColor = .systemGroupedBackground
        steeringView = HeaterSteeringPageView()
        steeringView.deviceNameLabel.text = viewModel.heater.deviceName
        setSwitchAndTemperatureLabel()

        steeringView.rollerSlider.maximumValue = 28
        steeringView.rollerSlider.minimumValue = 7
        steeringView.rollerSlider.value = viewModel.heater.temperature

        view.addSubview(steeringView)
        setupLayout()
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            steeringView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            steeringView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            steeringView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            steeringView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
}



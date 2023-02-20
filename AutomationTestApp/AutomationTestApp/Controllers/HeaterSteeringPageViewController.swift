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
        configureViewModel()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate.updateData(heater: viewModel.heater)
        viewModel.coordinator?.didFinishLightSteeringPage()
    }

    private func configureViewModel() {
        viewModel.reloadUIHandler = { [weak self] in
            guard let self = self else { return }
            self.setSwitchAndTemperatureLabel()
        }
    }

    private func setSwitchAndTemperatureLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.steeringView.switchButton.setOn(self.viewModel.heaterIsOn, animated: false)
            self.steeringView.temperatureLabel.text = self.viewModel.temperatureString
        }
    }

    @objc func sliderDidUpdate(sender: UISlider!) {
        viewModel.updateTemperature(value: sender.value)
    }

    @objc func switchDidUpdate(sender: UISwitch!) {
        viewModel.updateMode(isOn: sender.isOn)
    }
}

//MARK: - UserInteraction Event
private extension HeaterSteeringPageViewController {
    func setControlEvent() {
        steeringView.rollerSlider.addTarget(self, action: #selector(sliderDidUpdate), for: .valueChanged)
        steeringView.switchButton.addTarget(self, action: #selector(switchDidUpdate), for: .valueChanged)
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



//
//  LightSteeringPageViewController.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

final class LightSteeringPageViewController: UIViewController {
    
    //MARK: - Properties
    var delegate: HomeControllerDelegate!
    var viewModel: LightSteeringPageViewModel!
    var steeringView: LightSteeringPageView!
    
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
        delegate.realoadDataDisplay()
        viewModel.coordinator?.didFinishLightSteeringPage()
    }

    private func configureViewModel() {
        viewModel.reloadUIHandler = { [weak self] in
            guard let self = self else { return }
            self.setSwitchAndIntensityLabel()
        }
    }
    
    private func setSwitchAndIntensityLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.steeringView.switchButton.setOn(self.viewModel.lightIsOn, animated: false)
            self.steeringView.intensityLabel.text = self.viewModel.deviceIntensityString
        }
    }
    
    @objc func switchDidUpdate(mySwitch: UISwitch) {
        viewModel.updateMode(isOn: mySwitch.isOn)
    }
    
    @objc func sliderDidUpdate(sender: UISlider) {
        viewModel.updateIntensity(value: sender.value)
    }
}

//MARK: - UserInteraction Event
private extension LightSteeringPageViewController {
    func setControlEvent() {
        steeringView.rollerSlider.addTarget(self, action: #selector(sliderDidUpdate), for: .valueChanged)
        steeringView.switchButton.addTarget(self, action: #selector(switchDidUpdate), for:UIControl.Event.valueChanged)
    }
}

// MARK: - Setup
private extension LightSteeringPageViewController {
    func setup() {
        view.backgroundColor = .systemGroupedBackground
        steeringView = LightSteeringPageView()
        steeringView.deviceNameLabel.text = viewModel.light.deviceName
        setSwitchAndIntensityLabel()

        steeringView.rollerSlider.maximumValue = 100
        steeringView.rollerSlider.minimumValue = 0
        steeringView.rollerSlider.value = Float(viewModel.light.intensity)
        
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


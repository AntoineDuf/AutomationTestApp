//
//  LightSteeringPageViewController.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

class LightSteeringPageViewController: UIViewController {
    
    //MARK: - Properties
    var viewModel: LightSteeringPageViewModel!
    var steeringView: LightSteeringPageView!
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        setup()
        setControlEvent()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.light.intensity = Int(steeringView.rollerSlider.value)
    }
    
    private func setSwitch() {
        if viewModel.lightIsOn {
            self.steeringView.switchButton.setOn(false, animated: false)
            return
        }
        self.steeringView.switchButton.setOn(true, animated: false)
    }
    
    @objc func sliderUpdated(mySwitch: UISwitch) {
        let intensityValue = mySwitch.isOn ? 50 : 0
        viewModel.updateMode(isOn: mySwitch.isOn)
        DispatchQueue.main.async {
            self.steeringView.rollerSlider.value = Float(intensityValue)
            self.steeringView.intensityLabel.text = self.viewModel.deviceIntensityStringAdapter(position: intensityValue)
        }
    }
    
    @objc func updatePositionState(sender: UISlider!) {
        DispatchQueue.main.async {
            self.steeringView.intensityLabel.text = self.viewModel.deviceIntensityStringAdapter(position: Int(sender.value))
            self.steeringView.switchButton.setOn(true, animated: false)
            self.viewModel.light.mode = "ON"
        }
    }
}

//MARK: - UserInteraction Event
private extension LightSteeringPageViewController {
    func setControlEvent() {
        steeringView.rollerSlider.addTarget(self, action: #selector(updatePositionState), for: .valueChanged)
        steeringView.switchButton.addTarget(self, action: #selector(sliderUpdated), for:UIControl.Event.valueChanged)
    }
}

// MARK: - Setup
private extension LightSteeringPageViewController {
    func setup() {
        view.backgroundColor = .systemGroupedBackground
        steeringView = LightSteeringPageView()
        steeringView.deviceNameLabel.text = viewModel.light.deviceName
        steeringView.intensityLabel.text = viewModel.deviceIntensityStringAdapter(position: viewModel.light.intensity)
        setSwitch()
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


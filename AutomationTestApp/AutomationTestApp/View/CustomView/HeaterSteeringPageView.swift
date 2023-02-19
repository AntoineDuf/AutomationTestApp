//
//  HeaterSteeringPageView.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

class HeaterSteeringPageView: UIStackView {
    
    //MARK: - Properties
    private let topView = UIView()
    private let bottomView = UIView()
    let deviceNameLabel = NameSteeringPageLabel()
    let temperatureLabel = IntensitySteeringPageLabel()
    let rollerSlider = UISlider()
    let switchButton = UISwitch()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Setup
extension HeaterSteeringPageView {
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        distribution = .fillEqually
        
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        rollerSlider.translatesAutoresizingMaskIntoConstraints = false
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        topView.addSubview(deviceNameLabel)
        bottomView.addSubviews(temperatureLabel, switchButton, rollerSlider)
        addArrangedSubviews(topView, bottomView)
        
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            deviceNameLabel.bottomAnchor.constraint(equalTo: topView.layoutMarginsGuide.bottomAnchor),
            deviceNameLabel.leadingAnchor.constraint(equalTo: topView.layoutMarginsGuide.leadingAnchor),
            deviceNameLabel.trailingAnchor.constraint(equalTo: topView.layoutMarginsGuide.trailingAnchor),
            
            switchButton.leadingAnchor.constraint(equalTo: bottomView.layoutMarginsGuide.leadingAnchor),
            switchButton.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
            
            temperatureLabel.trailingAnchor.constraint(equalTo: bottomView.layoutMarginsGuide.trailingAnchor),
            temperatureLabel.leadingAnchor.constraint(equalTo: switchButton.layoutMarginsGuide.trailingAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: bottomView.layoutMarginsGuide.topAnchor, constant: 8),
            
            rollerSlider.topAnchor.constraint(equalTo: temperatureLabel.layoutMarginsGuide.bottomAnchor, constant: 40),
            rollerSlider.leadingAnchor.constraint(equalTo: bottomView.layoutMarginsGuide.leadingAnchor),
            rollerSlider.trailingAnchor.constraint(equalTo: bottomView.layoutMarginsGuide.trailingAnchor)
        ])
    }
}


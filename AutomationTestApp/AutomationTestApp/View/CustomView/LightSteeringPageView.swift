//
//  LightSteeringPageView.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

class LightSteeringPageView: UIStackView {
    
    //MARK: - Properties
    private let topView = UIView()
    private let bottomView = UIView()
    let deviceNameLabel = NameSteeringPageLabel()
    let intensityLabel = IntensitySteeringPageLabel()
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
extension LightSteeringPageView {
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        distribution = .fillEqually
        
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        rollerSlider.translatesAutoresizingMaskIntoConstraints = false
        
        topView.addSubview(deviceNameLabel)
        bottomView.addSubviews(intensityLabel, switchButton, rollerSlider)
        addArrangedSubviews(topView, bottomView)
        
        setupLayout()
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            deviceNameLabel.bottomAnchor.constraint(equalTo: topView.layoutMarginsGuide.bottomAnchor),
            deviceNameLabel.leadingAnchor.constraint(equalTo: topView.layoutMarginsGuide.leadingAnchor),
            deviceNameLabel.trailingAnchor.constraint(equalTo: topView.layoutMarginsGuide.trailingAnchor),
            
            switchButton.leadingAnchor.constraint(equalTo: bottomView.layoutMarginsGuide.leadingAnchor),
            switchButton.centerYAnchor.constraint(equalTo: intensityLabel.centerYAnchor),
            
            intensityLabel.trailingAnchor.constraint(equalTo: bottomView.layoutMarginsGuide.trailingAnchor),
            intensityLabel.leadingAnchor.constraint(equalTo: switchButton.layoutMarginsGuide.trailingAnchor),
            intensityLabel.topAnchor.constraint(equalTo: bottomView.layoutMarginsGuide.topAnchor, constant: 8),
            
            rollerSlider.topAnchor.constraint(equalTo: intensityLabel.layoutMarginsGuide.bottomAnchor, constant: 40),
            rollerSlider.leadingAnchor.constraint(equalTo: bottomView.layoutMarginsGuide.leadingAnchor),
            rollerSlider.trailingAnchor.constraint(equalTo: bottomView.layoutMarginsGuide.trailingAnchor)
        ])
    }
}


//
//  HeaterCell.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

class HeaterCell: UITableViewCell {

    //MARK: - Properties
    static let identifier = "HeaterCell"
    private var stackView = UIStackView()
    private var deviceName = DeviceNameLabel()
    private var deviceImage = DeviceImageView()
    private var deviceDegree = DeviceIntensityLabel()
    private var deviceMode = DeviceModeLabel()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      setup()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func configure(with heater: Heater) {
        deviceName.text = heater.deviceName
        if heater.mode == "OFF" {
            deviceImage.image = UIImage(named: "DeviceHeaterOffIcon")
        } else {
            deviceImage.image = UIImage(named: "DeviceHeaterOnIcon")
        }
        deviceDegree.text = deviceIntensityStringAdapter(mode: heater.mode, temperature: heater.temperature)
        deviceMode.text = heater.mode
    }

    private func deviceIntensityStringAdapter(mode: String, temperature: Float) -> String {
        if mode == "OFF" {
            return ""
        }
        return NSLocalizedString("at", comment: "") + " \(temperature)°"
    }
}

//MARK: - Setup
private extension HeaterCell {
    func setup() {
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubviews(deviceImage, deviceName, deviceDegree, deviceMode)
        
        contentView.addSubview(stackView)
        setupLayout()
    }
  
   func setupLayout() {
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
      stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
    ])
  }
}


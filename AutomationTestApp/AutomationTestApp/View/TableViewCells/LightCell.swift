//
//  LightCell.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

class LightCell: UITableViewCell {

    //MARK: - Properties
    static let identifier = "LightCell"
    private var stackView = UIStackView()
    private var deviceName = DeviceNameLabel()
    private var deviceImage = DeviceImageView()
    private var deviceIntensity = DeviceIntensityLabel()
    private var deviceMode = DeviceModeLabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      setup()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods
    func configure(with light: Light) {
        deviceName.text = light.deviceName
        if light.mode == "OFF" {
            deviceImage.image = UIImage(named: "DeviceLightOffIcon")
        } else {
            deviceImage.image = UIImage(named: "DeviceLightOnIcon")
        }
        deviceIntensity.text = deviceIntensityStringAdapter(position: light.intensity, mode: light.mode)
        deviceMode.text = light.mode
    }

    private func deviceIntensityStringAdapter(position: Int, mode: String) -> String {
        if position == 100 || mode == "OFF" {
            return ""
        }
        return NSLocalizedString("lightingAt", comment: "") + " \(position)%"
    }
}

//MARK: - Setup
private extension LightCell {
    func setup() {
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubviews(deviceImage, deviceName, deviceIntensity, deviceMode)
        
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


//
//  RollerCell.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

class RollerCell: UITableViewCell {

    //MARK: - Properties
    static let identifier = "RollerCell"
    private var stackView = UIStackView()
    private var deviceName = DeviceNameLabel()
    private var deviceImage = DeviceImageView()
    private var deviceIntensity = DeviceIntensityLabel()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      setup()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func configure(with roller: RollerShutter) {
        deviceName.text = roller.deviceName
        deviceImage.image = UIImage(named: "DeviceRollerShutterIcon")
        deviceIntensity.text = deviceIntensityStringAdapter(position: roller.position)
    }

    private func deviceIntensityStringAdapter(position: Int) -> String {
        switch position {
        case 0:
            return NSLocalizedString("closed", comment: "")
        case 100:
            return NSLocalizedString("opened", comment: "")
        default:
            return NSLocalizedString("openedAt", comment: "") + " \(position)%"
        }
    }
}

//MARK: - Setup
extension RollerCell {
    func setup() {
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubviews(deviceImage, deviceName, deviceIntensity)
        
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



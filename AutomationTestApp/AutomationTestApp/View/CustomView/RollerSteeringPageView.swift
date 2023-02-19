//
//  RollerSteeringPageView.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

class RollerSterringPageView: UIStackView {
    
    //MARK: - Properties
    private var contentView: CGRect!
    private let leftView = UIView()
    private let rightView = UIView()
    let deviceNameLabel = NameSteeringPageLabel()
    let positionLabel = IntensitySteeringPageLabel()
    let rollerSlider = UISlider()

    init(contentView: CGRect) {
        super.init(frame: .zero)
        self.contentView = contentView
        self.contentView = contentView
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Setup
extension RollerSterringPageView {
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        distribution = .fill
        
        positionLabel.textAlignment = .left
        
        rollerSlider.translatesAutoresizingMaskIntoConstraints = false
        rollerSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        
        leftView.translatesAutoresizingMaskIntoConstraints = false
        
        leftView.addSubviews(positionLabel, deviceNameLabel)
        rightView.addSubview(rollerSlider)
        addArrangedSubviews(leftView, rightView)
        
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            leftView.widthAnchor.constraint(equalToConstant: contentView.width * 0.66),
            
            rollerSlider.widthAnchor.constraint(equalToConstant: contentView.height / 2),
            rollerSlider.centerXAnchor.constraint(equalTo: rightView.centerXAnchor),
            rollerSlider.centerYAnchor.constraint(equalTo: rightView.centerYAnchor),
            
            positionLabel.trailingAnchor.constraint(equalTo: leftView.layoutMarginsGuide.trailingAnchor),
            positionLabel.leadingAnchor.constraint(equalTo: leftView.layoutMarginsGuide.leadingAnchor),
            positionLabel.centerYAnchor.constraint(equalTo: leftView.layoutMarginsGuide.centerYAnchor),
            positionLabel.centerXAnchor.constraint(equalTo: leftView.layoutMarginsGuide.centerXAnchor),
            
            deviceNameLabel.bottomAnchor.constraint(equalTo: positionLabel.layoutMarginsGuide.topAnchor, constant: -16),
            deviceNameLabel.leadingAnchor.constraint(equalTo: leftView.layoutMarginsGuide.leadingAnchor),
            deviceNameLabel.trailingAnchor.constraint(equalTo: leftView.layoutMarginsGuide.trailingAnchor),
            
        ])
    }
}

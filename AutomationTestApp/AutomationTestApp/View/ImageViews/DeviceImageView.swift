//
//  DeviceImageView.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

class DeviceImageView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 25).withPriority(999),
            heightAnchor.constraint(equalToConstant: 25).withPriority(999)
        ])
    }
}


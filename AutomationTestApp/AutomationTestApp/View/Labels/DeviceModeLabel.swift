//
//  DeviceModeLabel.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

class DeviceModeLabel: UILabel {
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        textColor = .secondaryLabel
        font = .preferredFont(forTextStyle: .headline)
        setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
}


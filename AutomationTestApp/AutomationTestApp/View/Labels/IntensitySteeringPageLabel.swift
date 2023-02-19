//
//  IntensitySteeringPageLabel.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

class IntensitySteeringPageLabel: UILabel {
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        textColor = .secondaryLabel
        font = .preferredFont(forTextStyle: .callout)
        setContentHuggingPriority(.defaultHigh, for: .horizontal)
        font = font.withSize(30)
        textAlignment = .right
        translatesAutoresizingMaskIntoConstraints = false
    }
}

//
//  NameSteeringPageLabel.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

class NameSteeringPageLabel: UILabel {
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        textColor = .label
        font = .preferredFont(forTextStyle: .subheadline)
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
        font = font.withSize(35)
    }
}

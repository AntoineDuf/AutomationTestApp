//
//  UserImageView.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

class UserImageView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        image = UIImage(systemName: "person.fill")
        tintColor = .lightGray
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 50).withPriority(999),
            heightAnchor.constraint(equalToConstant: 50).withPriority(999)
        ])
    }
}

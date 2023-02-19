//
//  UIStackView+Ext.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

extension UIStackView {
    
  func addArrangedSubviews(_ views: UIView...) {
    for view in views { self.addArrangedSubview(view) }
  }
}


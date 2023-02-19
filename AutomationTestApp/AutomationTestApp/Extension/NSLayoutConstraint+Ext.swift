//
//  NSLayoutConstraint+Ext.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

extension NSLayoutConstraint {
  
  func withPriority(_ rawValue: Float) -> Self {
    self.priority = UILayoutPriority(rawValue: rawValue)
    return self
  }
}

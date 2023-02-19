//
//  UIView+Ext.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

extension UIView {

  func addSubviews(_ views: UIView...) {
    for view in views { self.addSubview(view) }
  }
}

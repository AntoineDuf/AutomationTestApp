//
//  HomeTableView.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

class HomeTableView: UITableView {
  
  init() {
    super.init(frame: .zero, style: .insetGrouped)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    rowHeight = UITableView.automaticDimension
    translatesAutoresizingMaskIntoConstraints = false
      register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
      register(LightCell.self, forCellReuseIdentifier: LightCell.identifier)
      register(RollerCell.self, forCellReuseIdentifier: RollerCell.identifier)
      register(HeaterCell.self, forCellReuseIdentifier: HeaterCell.identifier)
  }
}

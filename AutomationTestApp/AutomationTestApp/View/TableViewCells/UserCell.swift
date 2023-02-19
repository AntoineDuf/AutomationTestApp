//
//  UserCell.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

class UserCell: UITableViewCell {
    
    //MARK: - Properties
    static let identifier = "UserCell"
    private var horizontalStackView = UIStackView()
    private var userImage = UserImageView()
    private var verticalStackView = UIStackView()
    private var nameLabel = DeviceNameLabel()
    private var adressLabel = DeviceModeLabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func configure(with user: User) {
        let userName = "\(user.firstName) \(user.lastName)"
        let adress = "\(user.address.city) \(user.address.street)"
        nameLabel.text = userName
        adressLabel.text = adress
    }
}

//MARK: - Setup
private extension UserCell {
    func setup() {
        selectionStyle = .none
        nameLabel.font = nameLabel.font.withSize(20)
        
        horizontalStackView.spacing = 8
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.spacing = 4
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        
        verticalStackView.isLayoutMarginsRelativeArrangement = true
        verticalStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
        verticalStackView.addArrangedSubviews(nameLabel, adressLabel)
        horizontalStackView.addArrangedSubviews(userImage, verticalStackView)
        
        contentView.addSubview(horizontalStackView)
        setupLayout()
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
}

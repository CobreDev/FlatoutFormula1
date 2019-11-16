//
//  DriverCell.swift
//  Formula 1
//
//  Created by Gio on 11/4/19.
//  Copyright © 2019 Gio. All rights reserved.
//

import UIKit

// MARK: - UIKit View
class DriverKitCell: UITableViewCell {
    static let reuseIdentifier = String(describing: self)
    
    private lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.Formula1Font.Regular
        return label
    }()
    
    private lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Formula1Font.Regular
        return label
    }()
    
    private lazy var firstNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Formula1Font.Regular
        return label
    }()
    
    private lazy var lastNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Formula1Font.Bold
        return label
    }()
    
    private lazy var nameHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstNameLabel, lastNameLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var constructorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Formula1Font.Regular
        return label
    }()
    
    private lazy var nameAndConstructorStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameHStackView, constructorLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [positionLabel, nameAndConstructorStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        activateConstraints()
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(stackView)
        contentView.addSubview(pointsLabel)
    }
    
    func activateConstraints() {
        let inset: CGFloat = 8
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset * 1.5),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset * 2),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            
            pointsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            pointsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
    
    func configure(_ driver: DriverStanding) {
        firstNameLabel.text = driver.driver.givenName
        lastNameLabel.text = driver.driver.familyName
        positionLabel.text = driver.position
        constructorLabel.text = driver.constructors[0].name
        pointsLabel.text = driver.points
    }
}
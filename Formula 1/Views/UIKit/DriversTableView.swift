//
//  DriversTableView.swift
//  Formula 1
//
//  Created by Gio on 11/16/19.
//  Copyright © 2022 Gio. All rights reserved.
//

import UIKit

final class DriversTableView: UITableView {
    required init() {
        super.init(frame: .zero, style: .plain)
        
        registerCell(DriverKitCell.self)
        
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 60
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


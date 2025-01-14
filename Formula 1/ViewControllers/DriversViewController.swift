//
//  DriversTableView.swift
//  Formula 1
//
//  Created by Gio on 11/4/19.
//  Copyright © 2022 Gio. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

// MARK: - Drivers View Controller
final class DriversViewController: UIViewController {
    // MARK: - Properties
    private lazy var viewModel: DriversViewModel = {
        let viewModel = DriversViewModel()
        
        viewModel.$dataSource.sink { _ in
            self.tableView.reloadSections(IndexSet([0]), with: .automatic)
            }
            .store(in: &cancellables)
        
        return viewModel
    }()
    
    var cancellables = Set<AnyCancellable>()
    
    lazy var tableView: DriversTableView = {
        let tableView = DriversTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
        
    // MARK: init
    required init() {
        cancellables = []
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        setupUI()
        setupNavBar()
        
        SelectYearViewModel.yearValueSubject
            .sink() { year in
                self.viewModel.fetchData(for: year)
            }
            .store(in: &cancellables)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Table View Delegate
extension DriversViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailViewController = DriverDetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - Table View DataSource
extension DriversViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { viewModel.numberOfSections }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { viewModel.sectionYearHeader }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { viewModel.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let driver = viewModel.item(at: indexPath.row) else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DriverKitCell.reuseIdentifier,
                                                 for: indexPath)
            as! DriverKitCell
        
        cell.configure(driver)
        return cell
    }
}

extension DriversViewController {
    func setupUI() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupNavBar() {
        let seasonButton = UIBarButtonItem(title: "Season",
                                           style: .plain,
                                           target: self,
                                           action: #selector(didtapSeasonButton(_:)))
        
        //navigationItem.rightBarButtonItem = seasonButton
    }
    
    @objc func didtapSeasonButton(_ sender: UIBarButtonItem) {
        #warning("TODO")
        
        let modalVC = UIHostingController(rootView: SettingsView())
        modalVC.modalPresentationStyle = .pageSheet
        
        // let viewController = SelectYearViewController()
        // viewController.delegate = self
        // viewController.modalPresentationStyle = .overCurrentContext

        // let navigationViewController = UINavigationController(rootViewController: viewController)
        // present(navigationViewController, animated: true)
        present(modalVC, animated: true)
    }
}

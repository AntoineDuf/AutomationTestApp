//
//  HomeDeviceListViewController.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

protocol HomeControllerDelegate {
    func realoadDataDisplay()
}

final class HomeDeviceListViewController: UIViewController {
    
    //MARK: - Properties
    var viewModel: HomeDeviceListViewModel!
    private var tableView = HomeTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureViewModel()
        viewModel.loadData()
    }
}

//MARK: - ViewModel handler
private extension HomeDeviceListViewController {
    func configureViewModel() {
        viewModel.reloadTableViewHandler = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.tableView.reloadData()
            }
        }
        viewModel.goToNextControllerHandler = { [weak self] in
            guard let self = self else { return }
            if let light = self.viewModel.selectedDevice as? Light {
                self.viewModel.coordinatorDelegate?.startLightSteeringPage(light: light, delegate: self)
            }
            if let heater = self.viewModel.selectedDevice as? Heater {
                self.viewModel.coordinatorDelegate?.startHeaterSteeringPage(heater: heater, delegate: self)
            }
            if let rollerShutter = self.viewModel.selectedDevice as? RollerShutter {
                self.viewModel.coordinatorDelegate?.startRollerSteeringPage(rollerShutter: rollerShutter, delegate: self)
            }
        }
    }
}

//MARK: - TableViewDataSource
extension HomeDeviceListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sectionCount
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rowCount(section: section)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = UserCell(style: .default, reuseIdentifier: UserCell.identifier)
            let user = viewModel.user
            cell.configure(with: user)
            return cell
        }
        if indexPath.section == 1 {
            let cell = LightCell(style: .default, reuseIdentifier: LightCell.identifier)
            cell.configure(with: viewModel.lights[indexPath.row])
            return cell
        }
        if indexPath.section == 2 {
            let cell = RollerCell(style: .default, reuseIdentifier: RollerCell.identifier)
            cell.configure(with: viewModel.rollers[indexPath.row])
            return cell
        }
        let cell = HeaterCell(style: .default, reuseIdentifier: HeaterCell.identifier)
        cell.configure(with: viewModel.heaters[indexPath.row])
        return cell
    }
}

//MARK: - TableViewDelegate
extension HomeDeviceListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            return
        }
        viewModel.didSelectDevice(section: indexPath.section, indexPath: indexPath.row)
    }
}

extension HomeDeviceListViewController: HomeControllerDelegate {
    func realoadDataDisplay() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Setup
private extension HomeDeviceListViewController {
    func setup() {
        title = NSLocalizedString("home", comment: "")
        view.backgroundColor = .systemGroupedBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        setupLayout()
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


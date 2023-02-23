//
//  HomeDeviceListViewController.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

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
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        viewModel.goToNextControllerHandler = { [weak self] in
            guard let self = self else { return }
            switch self.viewModel.selectedDevice {
            case is Light:
                self.viewModel.coordinator?.startLightSteeringPage(light: self.viewModel.selectedDevice as! Light, delegate: self)
            case is Heater:
                self.viewModel.coordinator?.startHeaterSteeringPage(heater: self.viewModel.selectedDevice as! Heater, delegate: self)
            case is RollerShutter:
                self.viewModel.coordinator?.startRollerSteeringPage(rollerShutter: self.viewModel.selectedDevice as! RollerShutter, delegate: self)
            default:
                return
            }
        }
    }
}

//MARK: - TableViewDataSource
extension HomeDeviceListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sectionCount + 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rowCount(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
            let user = viewModel.user
            cell.configure(with: user)
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LightCell.identifier, for: indexPath) as! LightCell
            let lights = viewModel.homeDevices[indexPath.section - 1]
            cell.configure(with: lights[indexPath.row] as! Light)
            return cell
        }
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: RollerCell.identifier, for: indexPath) as! RollerCell
            let rollers = viewModel.homeDevices[indexPath.section - 1]
            cell.configure(with: rollers[indexPath.row] as! RollerShutter)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: HeaterCell.identifier, for: indexPath) as! HeaterCell
        let heaters = viewModel.homeDevices[indexPath.section - 1]
        cell.configure(with: heaters[indexPath.row] as! Heater)
        return cell
    }
}

//MARK: - TableViewDelegate
extension HomeDeviceListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            return
        }
        viewModel.didSelectDevice(section: indexPath.section - 1, indexPath: indexPath.row)
    }
}

//MARK: - Other Controller Delegate
extension HomeDeviceListViewController: RollerSteeringDelegate {
    func updateData(rollerShutter: Deviceable) {
        viewModel.updateDevice(device: rollerShutter)
    }
}

extension HomeDeviceListViewController: LightSteeringDelegate {
    func updateData(light: Deviceable) {
        viewModel.updateDevice(device: light)
    }
}

extension HomeDeviceListViewController: HeaterSteeringDelegate {
    func updateData(heater: Deviceable) {
        viewModel.updateDevice(device: heater)
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


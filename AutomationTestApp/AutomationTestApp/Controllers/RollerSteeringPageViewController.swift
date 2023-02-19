//
//  RollerSteeringPageViewController.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

class RollerSteeringPageViewController: UIViewController {

    //MARK: - Properties
    var steeringView: RollerSterringPageView!
    var viewModel: RollerSteeringPageViewModel!

    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        setup()
        setControlEvent()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.rollerShutter.position = Int(steeringView.rollerSlider.value)
        viewModel.coordinator?.didFinishLightSteeringPage()
    }

    @objc func updatePositionLabel(sender: UISlider!) {
        let value = Int(sender.value)
        DispatchQueue.main.async {
            self.steeringView.positionLabel.text = self.viewModel.devicePositionStringAdapter(position: value)
        }
    }
}

//MARK: - UserInteraction Event
private extension RollerSteeringPageViewController {
    func setControlEvent() {
        steeringView.rollerSlider.addTarget(self, action: #selector(updatePositionLabel), for: .allEvents)
    }
}

// MARK: - Setup
private extension RollerSteeringPageViewController {
    func setup() {
        view.backgroundColor = .systemGroupedBackground
        steeringView = RollerSterringPageView(contentView: view.layer.frame)
        steeringView.deviceNameLabel.text = viewModel.rollerShutter.deviceName
        steeringView.positionLabel.text = self.viewModel.devicePositionStringAdapter(position: viewModel.rollerShutter.position)
        steeringView.rollerSlider.maximumValue = 100
        steeringView.rollerSlider.minimumValue = 0
        steeringView.rollerSlider.value = Float(viewModel.rollerShutter.position)

        view.addSubview(steeringView)
        setupLayout()
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            steeringView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            steeringView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            steeringView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            steeringView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
}

//
//  RollerSteeringPageViewController.swift
//  AutomationTestApp
//
//  Created by Antoine Dufayet on 19/02/2023.
//

import UIKit

final class RollerSteeringPageViewController: UIViewController {

    //MARK: - Properties
    var delegate: HomeControllerDelegate!
    var steeringView: RollerSterringPageView!
    var viewModel: RollerSteeringPageViewModel!

    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        setup()
        setControlEvent()
        configureViewModel()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate.realoadDataDisplay()
        viewModel.coordinator?.didFinishLightSteeringPage()
    }

    private func configureViewModel() {
        viewModel.reloadUIHandler = { [weak self] in
            guard let self = self else { return }
            self.setPositionLabel()
        }
    }

    private func setPositionLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.steeringView.positionLabel.text = self.viewModel.devicePositionStringAdapter
        }
    }

    @objc func sliderDidUpdate(sender: UISlider) {
        viewModel.updatePosition(value: sender.value)
    }
}

//MARK: - UserInteraction Event
private extension RollerSteeringPageViewController {
    func setControlEvent() {
        steeringView.rollerSlider.addTarget(self, action: #selector(sliderDidUpdate), for: .allEvents)
    }
}

// MARK: - Setup
private extension RollerSteeringPageViewController {
    func setup() {
        view.backgroundColor = .systemGroupedBackground
        steeringView = RollerSterringPageView(contentView: view.layer.frame)
        steeringView.deviceNameLabel.text = viewModel.rollerShutter.deviceName
        setPositionLabel()
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

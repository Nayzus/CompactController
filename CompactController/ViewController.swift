//
//  ViewController.swift
//  RectangleGradient
//
//  Created by Pavel Parshutkin on 02.07.2023.
//

import UIKit

class ViewController: UIViewController {

    lazy var presentButton: UIButton = configureUIButton()
    
    private var selected: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view.addSubview(presentButton)
        self.setupConstraints()
        
    }
    
    func configureUIButton() -> UIButton {
        
        var configuration = UIButton.Configuration.plain()
        
        configuration.title = "Present"
        let button = UIButton(configuration: configuration)
        
        button.addTarget(self, action: #selector(openModal), for: .touchUpInside)
        
        return button
    }

    @objc func openModal(sender: UIButton) {
        let vc = ModalViewController()
        vc.modalPresentationStyle = .popover
        vc.popoverPresentationController?.delegate = self
        vc.popoverPresentationController?.sourceView = sender
        vc.popoverPresentationController?.permittedArrowDirections = .up
        
        present(vc, animated: true)
    }

    private func setupConstraints() {
        presentButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            presentButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        ])
        
    }
}
extension ViewController: UIPopoverPresentationControllerDelegate {

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
}

class ModalViewController: UIViewController {
    
    private lazy var segmentControl: UISegmentedControl = configureSegment()
    private lazy var closeButton: UIButton = configureCloseButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        self.preferredContentSize = .init(width: 300, height: 280)
        
        self.view.addSubview(segmentControl)
        self.view.addSubview(closeButton)
        
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            closeButton.leftAnchor.constraint(greaterThanOrEqualTo: segmentControl.rightAnchor)
        ])
        
    }
    
    private func configureCloseButton() -> UIButton {
        var configuration = UIButton.Configuration.gray()
        
        configuration.image = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .regular) )
        configuration.baseForegroundColor = .systemGray2
        configuration.cornerStyle = .capsule
        
        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        
        return button
    }
    
    @objc func closeModal() {
        print("close")
        self.dismiss(animated: true)
    }
    
    
    private func configureSegment() -> UISegmentedControl {
        let view = UISegmentedControl(items: ["280pt", "150pt"])
        
        view.selectedSegmentIndex = 0
        view.addTarget(self, action: #selector(changeSelect), for: .valueChanged)
        
        return view
    }
    
    @objc private func changeSelect(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.preferredContentSize.height = 280
        } else {
            self.preferredContentSize.height = 150
        }
    }
}


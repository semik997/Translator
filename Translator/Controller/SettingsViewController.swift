//
//  SettingsViewController.swift
//  Translator
//
//  Created by Sem Koliesnikov on 09/02/2025.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewDelegate {
    
    private let settingsView = SettingsView()
    
    override func loadView() {
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.delegate = self
    }
    
    func didSelectOption(_ option: String) {
        print("Select: \(option)")
    }
    
    func didTapMainButton() {
        dismiss(animated: true, completion: nil)
    }
    
}

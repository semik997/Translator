//
//  ViewController.swift
//  Translator
//
//  Created by Sem Koliesnikov on 06/02/2025.
//

import UIKit

class TranslatorViewController: UIViewController, SwitchManagerDelegate, TranslatorViewDelegate {
    
    private let switchManager = SwitchManager()
    private let translatorView = TranslatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = translatorView
        switchManager.delegate = self
        translatorView.delegate = self
        translatorView.updateButtonStates(selectedPet: "dog")
        overrideUserInterfaceStyle = .light
    }
    
    
    
    func didTapSwitchButton() {
        switchManager.toggleSwitch()
    }
    
    func didUpdateLabels(humanText: String, petText: String) {
        translatorView.humanLabel.text = humanText
        translatorView.petLabel.text = petText
    }
    
    func didTapDogButton() {
        translatorView.petImageView.image = UIImage(named: "dog.png")
        translatorView.updateButtonStates(selectedPet: "dog")
    }
    
    func didTapCatButton() {
        translatorView.petImageView.image = UIImage(named: "cat.png")
        translatorView.updateButtonStates(selectedPet: "cat")
    }
    
    func didTapSpeakButton() {
        
    }
    func didTapMainButton() {
        
    }
    
    func didTapSettingButton() {
        
    }

    

}


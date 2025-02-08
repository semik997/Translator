//
//  ViewController.swift
//  Translator
//
//  Created by Sem Koliesnikov on 06/02/2025.
//

import UIKit

class TranslatorViewController: UIViewController, TranslatorViewDelegate {
    
    
//    private let switchManager = SwitchManager()
    private let translatorView = TranslatorView()
    var isSwitched: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view = translatorView
        translatorView.delegate = self
        translatorView.updateButtonStates(selectedPet: "dog")
        overrideUserInterfaceStyle = .light
    }
    
    
    
    func didUpdateLabels() {
        
        isSwitched.toggle()
        let humanText = isSwitched ? "PET" : "HUMAN"
        let petText = isSwitched ? "HUMAN" : "PET"
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


//
//  ViewController.swift
//  Translator
//
//  Created by Sem Koliesnikov on 06/02/2025.
//

import UIKit
import AVFoundation

class TranslatorViewController: UIViewController, SwitchManagerDelegate, TranslatorViewDelegate, MicrophoneManagerDelegate {
    
    private let switchManager = SwitchManager()
    private let translatorView = TranslatorView()
    private let microphoneManager = MicrophoneManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = translatorView
        switchManager.delegate = self
        translatorView.delegate = self
        microphoneManager.delegate = self
        translatorView.updateButtonStates(selectedPet: "dog")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        translatorView.showAllElements()
    }
    
    
    // Swapped pet and human label
    func didTapSwitchButton() {
        switchManager.toggleSwitch()
    }
    
    func didUpdateLabels(humanText: String, petText: String) {
        translatorView.updateLabels(humanText: humanText, petText: petText)
    }
    
    // Choise dog image
    func didTapDogButton() {
        translatorView.petImageView.image = UIImage(named: "dog.png")
        translatorView.updateButtonStates(selectedPet: "dog")
    }
    
    // Choise cat image
    func didTapCatButton() {
        translatorView.petImageView.image = UIImage(named: "cat.png")
        translatorView.updateButtonStates(selectedPet: "cat")
    }
    
    // Start record button is pressed
    func didTapSpeakButton() {
        microphoneManager.toggleRecording()
    }
    
    // Update UI when recording starts
    func didStartRecording() {
        translatorView.updateSpeakButton(isRecording: true)
    }
    
    // Update UI when recording stops
    func didStopRecording() {
        translatorView.showTranslationProcess {
            Router.showResultScreen(from: self, with: self.translatorView.petImageView.image, text: TranslationModel.getTranslatedText())
            
        }
        translatorView.updateSpeakButton(isRecording: false)
    }
    
    func didTapMainButton() {
        
    }
    
    func didTapSettingButton() {
        
    }
    
    // Call alert to go to settings if access is denied
    internal func showSettingAlert() {
        translatorView.showSettingAlert(in: self)
    }
    

}


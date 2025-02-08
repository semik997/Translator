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
        overrideUserInterfaceStyle = .light
    }
    
    
    // Swapped pet and human label
    func didTapSwitchButton() {
        switchManager.toggleSwitch()
    }
    
    func didUpdateLabels(humanText: String, petText: String) {
        translatorView.humanLabel.text = humanText
        translatorView.petLabel.text = petText
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
        if microphoneManager.isCurrentlyRecording() {
            microphoneManager.stopRecording()
        } else {
            microphoneManager.checkMicrophonePermission()
        }
    }
    
    // Update UI when recording starts
    func didStartRecording() {
        translatorView.updateSpeakButton(isRecording: true)
    }
    
    // Update UI when recording stops
    func didStopRecording() {
        translatorView.updateSpeakButton(isRecording: false)
    }
    
    func didTapMainButton() {
        
    }
    
    func didTapSettingButton() {
        
    }
    
    
    
    // Show alert to go to settings if access is denied
    internal func showSettingAlert() {
        let alert = UIAlertController(title: "Enable Microphone Access", message: "Please allow access to your mircophone to use the app’s features", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        
        present(alert, animated: true)
    }
    

}


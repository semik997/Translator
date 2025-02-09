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
        translatorView.showTranslationProcess {
            Router.showResultScreen(from: self, with: self.translatorView.petImageView.image, text: self.getTranslatedText())
            
        }
        translatorView.updateSpeakButton(isRecording: false)
    }
    
    func didTapMainButton() {
        
    }
    
    func didTapSettingButton() {
        
    }
    
    // Translation examples
    private func getTranslatedText() -> String {
        let exampleText = ["Hello", "What are you doing human?", "I'm hungry!!!", "I',m don'n understand you", "I missed you so much, but I don't understand what you're saying, please repeat it.", "Will you continue watching for a long time?"]
        return exampleText.randomElement() ?? "Something went wrong..."
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


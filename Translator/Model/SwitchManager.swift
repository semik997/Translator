//
//  SwitchManager.swift
//  Translator
//
//  Created by Sem Koliesnikov on 08/02/2025.
//
//
import Foundation

protocol SwitchManagerDelegate: AnyObject {
    func didUpdateLabels(humanText: String, petText: String)
}

class SwitchManager {
    
    weak var delegate: SwitchManagerDelegate?
    private var isSwitched = false
    
    func toggleSwitch() {
        isSwitched.toggle()
        let humanText = isSwitched ? "PET" : "HUMAN"
        let petText = isSwitched ? "HUMAN" : "PET"

        delegate?.didUpdateLabels(humanText: humanText, petText: petText)
    }
}

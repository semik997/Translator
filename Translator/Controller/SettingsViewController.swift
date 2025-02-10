//
//  SettingsViewController.swift
//  Translator
//
//  Created by Sem Koliesnikov on 09/02/2025.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let settingsOptions = [
        "Rate Us",
        "Share App",
        "Contact Us",
        "Restore Purchase",
        "Privacy Policy",
        "Terms of Use"
    ]
    
    private let settingsView = SettingsView()
    
    override func loadView() {
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsView.delegate = self
        settingsView.collectionView.delegate = self
        settingsView.collectionView.dataSource = self
        settingsView.collectionView.register(SettingsCollectionViewCell.self, forCellWithReuseIdentifier: "SettingsCell")
    }
    
    func didTapMainButton() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingsOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SettingsCell", for: indexPath) as! SettingsCollectionViewCell
        cell.configure(with: settingsOptions[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedOption = settingsOptions[indexPath.row]
        
        switch selectedOption {
        case "Rate Us":
            openAppStore()
        case "Share App":
            shareApp()
        case "Contact Us":
            openContactUs()
        case "Restore Purchase":
            restorePurchase()
        case "Privacy Policy":
            privacyPolicy()
        case "Terms of Use":
            openTermsOfUse()
        default:
            break
        }
    }
    
    // MARK: - Actions
    
    // Open App Store
    private func openAppStore() {
        guard let url = URL(string: "itms-apps://itunes.apple.com") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    // Share App
    private func shareApp() {
        let appURL = "https://apple.com"
        let activityVC = UIActivityViewController(activityItems: [appURL], applicationActivities: nil)
        present(activityVC, animated: true)
    }
    
    // Open client e-mail for contact
    private func openContactUs() {
        guard let url = URL(string: "mailto:info@example.com") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    // Restoring purchases
    private func restorePurchase() {
        let alert = UIAlertController(
            title: "No Purchases Found",
            message: "There are no purchased items to restore",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // Open page with privacy policy
    private func privacyPolicy() {
        guard let url = URL(string: "https://apple.com") else { return }
        UIApplication.shared.open(url)
    }
    
    // Open page with terms of use
    private func openTermsOfUse() {
        guard let url = URL(string: "https://apple.com") else { return }
        UIApplication.shared.open(url)
    }
    
    
}

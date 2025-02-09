//
//  ResultViewController.swift
//  Translator
//
//  Created by Sem Koliesnikov on 09/02/2025.
//

import UIKit

class ResultViewController: UIViewController {
    
    var selectedAnimalImage: UIImage?
    var translatedText: String?
    
    private let resultView = ResultView()
    
    override func loadView() {
        view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultView.updateView(with: selectedAnimalImage, text: translatedText)
        resultView.retryButton.addTarget(self, action: #selector(retryRecording), for: .touchUpInside)
        setupCustomBackButton()
        setupNavigationTitle()
        
    }
    
    @objc private func retryRecording() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupCustomBackButton() {
        let closeButton = UIButton(type: .custom)
        let image = UIImage(systemName: "xmark.circle")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))
        closeButton.setImage(image, for: .normal)
        closeButton.tintColor = UIColor.darkGray
        closeButton.backgroundColor = .white
        closeButton.layer.cornerRadius = 20
        closeButton.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: closeButton)
        navigationItem.leftBarButtonItem = barButton
        
        
    }
    
    private func setupNavigationTitle() {
        let label = UILabel()
        label.text = "Result"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.sizeToFit()
        
        navigationItem.titleView = label
    }
    
    @objc private func closeButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
}

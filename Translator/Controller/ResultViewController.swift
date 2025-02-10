//
//  ResultViewController.swift
//  Translator
//
//  Created by Sem Koliesnikov on 09/02/2025.
//

import UIKit

class ResultViewController: UIViewController, ResultViewDelegate {
    
    private let resultView = ResultView()
    var selectedAnimalImage: UIImage?
    var translatedText: String?
    
    override func loadView() {
        view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultView.updateView(with: selectedAnimalImage, text: translatedText)
        resultView.retryButton.addTarget(self, action: #selector(navigateToMainScreen), for: .touchUpInside)
        setupCustomBackButton()
        setupNavigationTitle()
    }
    
    private func setupCustomBackButton() {
        let closeButton = UIButton(type: .custom)
        let image = UIImage(systemName: "xmark.circle")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))
        closeButton.setImage(image, for: .normal)
        closeButton.tintColor = UIColor.darkGray
        closeButton.backgroundColor = .white
        closeButton.layer.cornerRadius = 20
        closeButton.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        closeButton.addTarget(self, action: #selector(navigateToMainScreen), for: .touchUpInside)
        
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
    
    @objc internal func navigateToMainScreen() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}

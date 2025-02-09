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
    }
    
    @objc private func retryRecording() {
        navigationController?.popViewController(animated: true)
    }
 
    

}

//
//  Router.swift
//  Translator
//
//  Created by Sem Koliesnikov on 09/02/2025.
//

import UIKit

class Router {
    
    static func showResultScreen(from viewController: UIViewController, with image: UIImage?, text: String?) {
        let resultVC = ResultViewController()
        resultVC.selectedAnimalImage = image
        resultVC.translatedText = text
        viewController.navigationController?.pushViewController(resultVC, animated: true)
    }
    
    static func showSettings(from viewController: UIViewController) {
        let settingsVC = SettingsViewController()
        settingsVC.modalPresentationStyle = .overFullScreen
        settingsVC.modalTransitionStyle = .coverVertical
        viewController.present(settingsVC, animated: true, completion: nil)
    }
    
}

//
//  ViewController.swift
//  Translator
//
//  Created by Sem Koliesnikov on 06/02/2025.
//

import UIKit

class TranslatorViewController: UIViewController {
    
    private let catButton = UIButton(type: .system)
    private let dogButton = UIButton(type: .system)
    private let petImageView = UIImageView(image: UIImage(named: "dog.png"))

    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        setupView()
        overrideUserInterfaceStyle = .light
        
    }
    
    private func setupView() {
        
        // Translator Label
        let titleLabel = UILabel()
        titleLabel.text = "Translator"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Human and Pet labels
        let humanLabel = UILabel()
        humanLabel.text = "HUMAN"
        humanLabel.font = UIFont.systemFont(ofSize: 16)
        humanLabel.textAlignment = .center
        humanLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let petLabel = UILabel()
        petLabel.text = "PET"
        petLabel.font = UIFont.systemFont(ofSize: 16)
        petLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let arrowsButton = UIButton()
        var arrowButtonConfig = UIButton.Configuration.plain()
        arrowButtonConfig.title = "⇆"
        arrowButtonConfig.baseForegroundColor = .black
        arrowButtonConfig.attributedTitle = AttributedString("⇆", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 30)]))
        arrowsButton.configuration = arrowButtonConfig
        arrowsButton.translatesAutoresizingMaskIntoConstraints = false
        
        let labelStackView = UIStackView(arrangedSubviews: [humanLabel, arrowsButton, petLabel])
        labelStackView.axis = .horizontal
        labelStackView.spacing = 16
        labelStackView.alignment = .center
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelStackView)
        
        // Start speak button
        let speakButton = UIButton(type: .system)
        var speakButtonConfig = UIButton.Configuration.plain()
        speakButtonConfig.image = UIImage(systemName: "microphone.badge.ellipsis")
        speakButtonConfig.imagePlacement = .top
        speakButtonConfig.imagePadding = 10
        speakButtonConfig.baseForegroundColor = .black
        speakButtonConfig.title = "Start Speak"
        speakButtonConfig.attributedTitle = AttributedString("Start Speak", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 16)]))
        speakButton.configuration = speakButtonConfig
        speakButton.configuration?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 50)
        
        speakButton.translatesAutoresizingMaskIntoConstraints = false
        speakButton.imageView?.contentMode = .scaleToFill
        speakButton.backgroundColor = .white
        speakButton.layer.cornerRadius = 20
        speakButton.layer.shadowColor = UIColor.black.cgColor
        speakButton.layer.shadowOpacity = 0.3
        speakButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.addSubview(speakButton)
        

        
        // Choice buttons animals
        
        
        catButton.setImage(UIImage(named: "cat.png"), for: .normal)
        catButton.imageView?.contentMode = .scaleAspectFit
        catButton.tintColor = .black
        catButton.addTarget(self, action: #selector(selectCat), for: .touchUpInside)
        catButton.translatesAutoresizingMaskIntoConstraints = false
        
    
        
        dogButton.setImage(UIImage(named: "dog.png"), for: .normal)
        dogButton.imageView?.contentMode = .scaleAspectFit
        dogButton.tintColor = .black
        dogButton.addTarget(self, action: #selector(selectDog), for: .touchUpInside)
        dogButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        let petSwitchView = UIView()
        petSwitchView.backgroundColor = .white
        petSwitchView.layer.cornerRadius = 20
        petSwitchView.layer.shadowOpacity = 0.3
        petSwitchView.layer.shadowRadius = 5
        petSwitchView.layer.shadowOffset = CGSize(width: 0, height: 2)
        petSwitchView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let petStackView = UIStackView(arrangedSubviews: [catButton, dogButton])
        petStackView.axis = .vertical
        petStackView.spacing = 10
        petStackView.alignment = .center
        petStackView.distribution = .fillEqually
        petStackView.translatesAutoresizingMaskIntoConstraints = false
        petSwitchView.addSubview(petStackView)
        
        
        
        let speakStackView = UIStackView(arrangedSubviews: [speakButton, petSwitchView])
        speakStackView.axis = .horizontal
        speakStackView.spacing = 12
        speakStackView.alignment = .center
        speakStackView.distribution = .equalCentering
        speakStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(speakStackView)
        
        
        // Pet Image
        
        petImageView.contentMode = .scaleAspectFit
        petImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(petImageView)
  
        
        // Bottom Buttons
        let mainButton = UIButton(type: .system)
        var mainButtonConfig = UIButton.Configuration.plain()
        mainButtonConfig.image = UIImage(systemName: "bubble.left.and.bubble.right")
        mainButtonConfig.imagePlacement = .top
        mainButtonConfig.imagePadding = 10
        mainButtonConfig.baseForegroundColor = .black
        mainButtonConfig.title = "Translator"
        mainButtonConfig.attributedTitle = AttributedString("Translator", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 12)]))
        
        mainButton.configuration = mainButtonConfig
        
        
        let settingsButton = UIButton(type: .system)
        var settingButtonConfig = UIButton.Configuration.plain()
        settingButtonConfig.image = UIImage(systemName: "gear")
        settingButtonConfig.imagePlacement = .top
        settingButtonConfig.imagePadding = 10
        settingButtonConfig.baseForegroundColor = .black
        settingButtonConfig.title = "Settings"
        settingButtonConfig.attributedTitle = AttributedString("Settings", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 12)]))
        
        settingsButton.configuration = settingButtonConfig
        
        
        let bottomStackView = UIStackView(arrangedSubviews: [mainButton, settingsButton])
        bottomStackView.backgroundColor = .white
        bottomStackView.layer.cornerRadius = 10
        bottomStackView.axis = .horizontal
        bottomStackView.spacing = 30
        bottomStackView.distribution = .fillEqually
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            labelStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            labelStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            
            
            speakStackView.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 30),
            speakStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            speakStackView.widthAnchor.constraint(equalToConstant: 320),
            speakStackView.heightAnchor.constraint(equalToConstant: 176),

            speakButton.widthAnchor.constraint(equalToConstant: 178),
            speakButton.heightAnchor.constraint(equalToConstant: 176),
            
            petSwitchView.widthAnchor.constraint(equalToConstant: 107),
            petSwitchView.heightAnchor.constraint(equalToConstant: 176),
            
            petStackView.centerXAnchor.constraint(equalTo: petSwitchView.centerXAnchor),
            petStackView.centerYAnchor.constraint(equalTo: petSwitchView.centerYAnchor),
            
            
            catButton.widthAnchor.constraint(equalToConstant: 60),
            catButton.heightAnchor.constraint(equalToConstant: 60),
            
            dogButton.widthAnchor.constraint(equalToConstant: 60),
            dogButton.heightAnchor.constraint(equalToConstant: 60),
            
            
            petImageView.topAnchor.constraint(equalTo: speakButton.bottomAnchor, constant: 40),
            petImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            petImageView.widthAnchor.constraint(equalToConstant: 184),
            petImageView.heightAnchor.constraint(equalToConstant: 184),
            
            settingsButton.widthAnchor.constraint(equalToConstant: 100),
            settingsButton.heightAnchor.constraint(equalToConstant: 80),
            
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomStackView.widthAnchor.constraint(equalToConstant: 216),
            bottomStackView.heightAnchor.constraint(equalToConstant: 82)
            
        ])
        
        updateButtonStates(selectedPet: "dog")
    
    }
    
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [UIColor(hex: "#F3F5F6", alpha: 1).cgColor,
                                UIColor(hex: "#C9FFE0", alpha: 1).cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @objc private func selectCat() {
        petImageView.image = UIImage(named: "cat.png")
        updateButtonStates(selectedPet: "cat")
    }
    
    @objc private func selectDog() {
        petImageView.image = UIImage(named: "dog.png")
        updateButtonStates(selectedPet: "dog")
    }
    
    private func updateButtonStates(selectedPet: String) {
        if selectedPet == "dog" {
            dogButton.alpha = 1.0
            catButton.alpha = 0.4
        } else {
            dogButton.alpha = 0.4
            catButton.alpha = 1.0
        }
    }
    

}


//
//  TranslatorView.swift
//  Translator
//
//  Created by Sem Koliesnikov on 08/02/2025.
//

import UIKit

protocol TranslatorViewDelegate: AnyObject {
    func didTapDogButton()
    func didTapCatButton()
    func didTapSwitchButton()
    func didTapSpeakButton()
    func didTapMainButton()
    func didTapSettingButton()
    
}

class TranslatorView: UIView {
    
    weak var delegate: TranslatorViewDelegate?
    
    
    // MARK: - Create UI elements

    private let catBackgroundView = UIView()
    private let dogBackgroundView = UIView()
    
    private let petSwitchView = UIView()
    private var petStackView = UIStackView()
    private let speakStackView = UIStackView()
    
    private let arrowsButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .black
        config.attributedTitle = AttributedString("⇆", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 30)]))
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [humanLabel, arrowsButton, petLabel])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    private let speakButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "microphone.badge.ellipsis")
        config.imagePlacement = .top
        config.imagePadding = 10
        config.baseForegroundColor = .black
        config.attributedTitle = AttributedString("Start Speak", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 16)]))
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 50)
        
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleToFill
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        return button
    }()
    
    private let catButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "cat.png")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let dogButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "dog.png")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    private let mainButton: UIButton = {
        var button = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "bubble.left.and.bubble.right")
        config.imagePlacement = .top
        config.imagePadding = 10
        config.baseForegroundColor = .black
        config.attributedTitle = AttributedString("Translator", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 12)]))
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "gearshape")
        config.imagePlacement = .top
        config.imagePadding = 10
        config.baseForegroundColor = .black
        config.attributedTitle = AttributedString("Settings", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 12)]))
        button.configuration = config
        button.alpha = 0.4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mainButton, settingsButton])
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 10
        stackView.axis = .horizontal
        stackView.spacing = 30
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Translator"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let humanLabel: UILabel = {
        let label = UILabel()
        label.text = "HUMAN"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let petLabel: UILabel = {
        let label = UILabel()
        label.text = "PET"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let petImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dog.png")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradientBackground(topColor: Constants.UI.gradientTopColor, bottomColor: Constants.UI.gradientBottomColor)
    }
    
    // UI Setting
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(labelStackView)
        addSubview(speakStackView)
        addSubview(petImageView)
        addSubview(bottomStackView)
        setGradientBackground(topColor: Constants.UI.gradientTopColor, bottomColor: Constants.UI.gradientBottomColor)
        
        arrowsButton.addTarget(self, action: #selector(switchButtonTapped), for: .touchUpInside)
        speakButton.addTarget(self, action: #selector(speakButtonTapped), for: .touchUpInside)
        catButton.addTarget(self, action: #selector(selectCat), for: .touchUpInside)
        dogButton.addTarget(self, action: #selector(selectDog), for: .touchUpInside)
        mainButton.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        
        
        
        // Customize background under pet buttons
        catBackgroundView.backgroundColor = UIColor(hex: "#D1E7FC", alpha: 1)
        dogBackgroundView.backgroundColor = UIColor(hex: "#ECFBC7", alpha: 1)
        catBackgroundView.layer.cornerRadius = 16
        dogBackgroundView.layer.cornerRadius = 16
        catBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        dogBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        // Setting up the pet switch
        petSwitchView.backgroundColor = .white
        petSwitchView.layer.cornerRadius = 20
        petSwitchView.layer.shadowOpacity = 0.3
        petSwitchView.layer.shadowRadius = 5
        petSwitchView.layer.shadowOffset = CGSize(width: 0, height: 2)
        petSwitchView.translatesAutoresizingMaskIntoConstraints = false
        
        // Stack for pet buttons
        petStackView = UIStackView(arrangedSubviews: [catBackgroundView, dogBackgroundView])
        petStackView.axis = .vertical
        petStackView.spacing = 30
        petStackView.alignment = .center
        petStackView.distribution = .fillEqually
        petStackView.translatesAutoresizingMaskIntoConstraints = false
        petSwitchView.addSubview(petStackView)
        
        petSwitchView.addSubview(catButton)
        petSwitchView.addSubview(dogButton)
        
        // Stack for speak button and switcher
        speakStackView.axis = .horizontal
        speakStackView.spacing = 12
        speakStackView.alignment = .center
        speakStackView.distribution = .equalCentering
        speakStackView.addArrangedSubview(speakButton)
        speakStackView.addArrangedSubview(petSwitchView)
        speakStackView.translatesAutoresizingMaskIntoConstraints = false
        
        petImageView.contentMode = .scaleAspectFit
        petImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // Constraints settting
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            humanLabel.widthAnchor.constraint(equalToConstant: 135),
            petLabel.widthAnchor.constraint(equalToConstant: 135),
            arrowsButton.widthAnchor.constraint(equalToConstant: 24),
            arrowsButton.heightAnchor.constraint(equalToConstant: 24),
            
            labelStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            labelStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            speakStackView.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 70),
            speakStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            speakStackView.widthAnchor.constraint(equalToConstant: 320),
            speakStackView.heightAnchor.constraint(equalToConstant: 176),
            
            speakButton.widthAnchor.constraint(equalToConstant: 178),
            speakButton.heightAnchor.constraint(equalToConstant: 176),
            
            petSwitchView.widthAnchor.constraint(equalToConstant: 107),
            petSwitchView.heightAnchor.constraint(equalToConstant: 176),
            
            petStackView.centerXAnchor.constraint(equalTo: petSwitchView.centerXAnchor),
            petStackView.centerYAnchor.constraint(equalTo: petSwitchView.centerYAnchor),
            
            catButton.widthAnchor.constraint(equalToConstant: 40),
            catButton.heightAnchor.constraint(equalToConstant: 40),
            catButton.centerXAnchor.constraint(equalTo: catBackgroundView.centerXAnchor),
            catButton.centerYAnchor.constraint(equalTo: catBackgroundView.centerYAnchor),
            
            catBackgroundView.widthAnchor.constraint(equalToConstant: 70),
            catBackgroundView.heightAnchor.constraint(equalToConstant: 70),
            catBackgroundView.centerXAnchor.constraint(equalTo: petSwitchView.centerXAnchor),
            catBackgroundView.topAnchor.constraint(equalTo: petSwitchView.topAnchor, constant: 10),
            
            
            dogButton.widthAnchor.constraint(equalToConstant: 40),
            dogButton.heightAnchor.constraint(equalToConstant: 40),
            dogButton.centerXAnchor.constraint(equalTo: dogBackgroundView.centerXAnchor),
            dogButton.centerYAnchor.constraint(equalTo: dogBackgroundView.centerYAnchor),
            
            dogBackgroundView.widthAnchor.constraint(equalToConstant: 70),
            dogBackgroundView.heightAnchor.constraint(equalToConstant: 70),
            dogBackgroundView.centerXAnchor.constraint(equalTo: petSwitchView.centerXAnchor),
            dogBackgroundView.topAnchor.constraint(equalTo: catBackgroundView.bottomAnchor, constant: 10),
            
            
            petImageView.topAnchor.constraint(equalTo: speakButton.bottomAnchor, constant: 60),
            petImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            petImageView.widthAnchor.constraint(equalToConstant: 184),
            petImageView.heightAnchor.constraint(equalToConstant: 184),
            
            settingsButton.widthAnchor.constraint(equalToConstant: 100),
            settingsButton.heightAnchor.constraint(equalToConstant: 80),
            
            bottomStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bottomStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomStackView.widthAnchor.constraint(equalToConstant: 216),
            bottomStackView.heightAnchor.constraint(equalToConstant: 82)
            
        ])
    }
    
    // MARK: - Funcs
    
    @objc private func switchButtonTapped() {
        delegate?.didTapSwitchButton()
    }
    
    @objc private func speakButtonTapped() {
        delegate?.didTapSpeakButton()
    }
    
    @objc private func selectCat() {
        delegate?.didTapCatButton()
    }
    
    @objc private func selectDog() {
        delegate?.didTapDogButton()
    }
    
    @objc private func mainButtonTapped() {
        delegate?.didTapMainButton()
    }
    
    @objc private func settingsButtonTapped() {
        delegate?.didTapSettingButton()
    }
    
    // Shade of pet's choice
    func updateButtonStates(selectedPet: String) {
        if selectedPet == "dog" {
            dogButton.alpha = 1.0
            catButton.alpha = 0.4
        } else {
            dogButton.alpha = 0.4
            catButton.alpha = 1.0
        }
    }
    
    func updateLabels(humanText: String, petText: String) {
        humanLabel.text = humanText
        petLabel.text = petText
    }
    
    // Show alert to go to settings if access is denied
    func showSettingAlert(in viewController: UIViewController) {
        let alert = UIAlertController(
            title: "Enable Microphone Access",
            message: "Please allow access to your mircophone to use the app’s features",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        viewController.present(alert, animated: true)
    }
    
    // Update speak button after pressed
    func updateSpeakButton(isRecording: Bool) {
        var config = speakButton.configuration
        config?.image = UIImage(systemName: isRecording ? "microphone.and.signal.meter" : "microphone.badge.ellipsis")
        config?.title = isRecording ? "Recording....." : "Start Speak"
        speakButton.configuration = config
    }
    
    func showTranslationProcess(completion: @escaping() -> Void) {
        hideAllElements()
        let translationLabel = UILabel()
        translationLabel.text = "Process of translation..."
        translationLabel.font = .systemFont(ofSize: 24, weight: .bold)
        translationLabel.textAlignment = .center
        translationLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(translationLabel)
        
        NSLayoutConstraint.activate([
            translationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            translationLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            translationLabel.isHidden = true
            completion()
        }
    }
    
    // Show items after returning to home screen
    func showAllElements() {
        titleLabel.isHidden = false
        speakButton.isHidden = false
        labelStackView.isHidden = false
        petStackView.isHidden = false
        dogButton.isHidden = false
        catButton.isHidden = false
        speakStackView.isHidden = false
    }
    // Hiding elements
    func hideAllElements() {
        titleLabel.isHidden = true
        speakButton.isHidden = true
        labelStackView.isHidden = true
        petStackView.isHidden = true
        dogButton.isHidden = true
        catButton.isHidden = true
        speakStackView.isHidden = true
    }
    
    
}

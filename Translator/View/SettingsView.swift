//
//  SettingsView.swift
//  Translator
//
//  Created by Sem Koliesnikov on 09/02/2025.
//

import UIKit

protocol SettingsViewDelegate: AnyObject {
    func didSelectOption(_ option: String)
    func didTapMainButton()
}

class SettingsView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: SettingsViewDelegate?
    
    private let settingsOptions = [
        "Rate Us",
        "Share App",
        "Contact Us",
        "Restore Purchase",
        "Privacy Policy",
        "Terms of Use"
    ]
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 50)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // Bottom Buttons
    private let mainButton: UIButton = {
        var button = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "bubble.left.and.bubble.right")
        config.imagePlacement = .top
        config.imagePadding = 10
        config.baseForegroundColor = .black
        config.attributedTitle = AttributedString("Translator", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 12)]))
        button.configuration = config
        button.alpha = 0.4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "gear")
        config.imagePlacement = .top
        config.imagePadding = 10
        config.baseForegroundColor = .black
        config.attributedTitle = AttributedString("Settings", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 12)]))
        button.configuration = config
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
    
    override init(frame: CGRect) {
        super .init(frame: UIScreen.main.bounds)
        setupUI()
        setupConstraints()
        setGradientBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(collectionView)
        addSubview(bottomStackView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SettingsCollectionViewCell.self, forCellWithReuseIdentifier: "SettingsCell")
        
        bottomStackView.addArrangedSubview(mainButton)
        bottomStackView.addArrangedSubview(settingsButton)
        
        mainButton.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor, constant: -20),
            
            bottomStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bottomStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomStackView.widthAnchor.constraint(equalToConstant: 216),
            bottomStackView.heightAnchor.constraint(equalToConstant: 82)
            
        ])
    }
    
    // Setup background
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [UIColor(hex: "#F3F5F6", alpha: 1).cgColor,
                                UIColor(hex: "#C9FFE0", alpha: 1).cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @objc private func mainButtonTapped() {
        delegate?.didTapMainButton()
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
        delegate?.didSelectOption(settingsOptions[indexPath.row])
    }


}

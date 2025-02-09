//
//  ResultView.swift
//  Translator
//
//  Created by Sem Koliesnikov on 09/02/2025.
//

import UIKit

class ResultView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Result"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let animalImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let dialogBox: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textAlignment = .center
        textView.layer.cornerRadius = 12
        textView.layer.borderColor = UIColor.systemGray.cgColor
        textView.layer.borderWidth = 2
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Repeat", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setGradientBackground()
        addSubview(titleLabel)
        addSubview(animalImageView)
        addSubview(dialogBox)
        addSubview(retryButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            dialogBox.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            dialogBox.centerXAnchor.constraint(equalTo: centerXAnchor),
            dialogBox.widthAnchor.constraint(equalToConstant: 291),
            dialogBox.heightAnchor.constraint(equalToConstant: 142),
            
            animalImageView.topAnchor.constraint(equalTo: dialogBox.bottomAnchor, constant: 30),
            animalImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            animalImageView.widthAnchor.constraint(equalToConstant: 184),
            animalImageView.heightAnchor.constraint(equalToConstant: 184),
            
            retryButton.topAnchor.constraint(equalTo: animalImageView.bottomAnchor, constant: 30),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.widthAnchor.constraint(equalToConstant: 150),
            retryButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }

    func updateView(with image: UIImage?, text: String?) {
        animalImageView.image = image
        if let text = text {
            dialogBox.text = text
            retryButton.isHidden = true
        } else {
            dialogBox.text = "No translation available"
        }
    }
    
    
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [UIColor(hex: "#F3F5F6", alpha: 1).cgColor,
                                UIColor(hex: "#C9FFE0", alpha: 1).cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

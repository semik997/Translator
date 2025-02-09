//
//  ResultView.swift
//  Translator
//
//  Created by Sem Koliesnikov on 09/02/2025.
//

import UIKit

class ResultView: UIView {
    
    let animalImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let bubbleImageView: UIImageView = {
        let imageView = UIImageView()
        let bubbleImage = UIImage(systemName: "bubble.middle.bottom.fill")?.withRenderingMode(.alwaysTemplate)
        imageView.image = bubbleImage
        imageView.tintColor = UIColor(hex: "#D6DCFF")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let dialogBox: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.backgroundColor = .clear
        textView.textAlignment = .center
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 80, left: 20, bottom: 80, right: 20)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradientBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(bubbleImageView)
        addSubview(dialogBox)
        addSubview(animalImageView)
        addSubview(retryButton)
        
        NSLayoutConstraint.activate([
            
            bubbleImageView.topAnchor.constraint(equalTo: topAnchor, constant: 229),
            bubbleImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bubbleImageView.widthAnchor.constraint(equalToConstant: 350),
            bubbleImageView.heightAnchor.constraint(equalToConstant: 250),
            
            dialogBox.centerXAnchor.constraint(equalTo: bubbleImageView.centerXAnchor),
            dialogBox.centerYAnchor.constraint(equalTo: bubbleImageView.centerYAnchor),
            dialogBox.widthAnchor.constraint(equalTo: bubbleImageView.widthAnchor, constant: -30),
            dialogBox.heightAnchor.constraint(equalTo: bubbleImageView.heightAnchor, constant: -30),
            
            animalImageView.topAnchor.constraint(equalTo: topAnchor, constant: 496),
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

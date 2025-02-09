//
//  ResultView.swift
//  Translator
//
//  Created by Sem Koliesnikov on 09/02/2025.
//

import UIKit

protocol ResultViewDelegate: AnyObject {
    func navigateToMainScreen()
}

class ResultView: UIView {
    
    weak var delegate: ResultViewDelegate?
    
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
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 80, left: 20, bottom: 80, right: 20)
        return textView
    }()
    
    let retryButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "arrow.trianglehead.clockwise")
        config.attributedTitle = AttributedString(" Repeat", attributes: AttributeContainer([.font: UIFont.boldSystemFont(ofSize: 18)]))
        config.baseForegroundColor = .black
        
        button.configuration = config
        button.backgroundColor = UIColor(hex: "#D6DCFF")
        button.layer.cornerRadius = 16
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.isHidden = true
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
        
        dialogBox.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(textViewTapped)))
        retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        
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
            
            retryButton.topAnchor.constraint(equalTo: topAnchor, constant: 317),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.widthAnchor.constraint(equalToConstant: 291),
            retryButton.heightAnchor.constraint(equalToConstant: 54)
            
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
    
    @objc private func textViewTapped() {
        dialogBox.isHidden = true
        bubbleImageView.isHidden = true
        retryButton.isHidden = false
    }
    
    @objc private func retryButtonTapped() {
        delegate?.navigateToMainScreen()
    }
    
}

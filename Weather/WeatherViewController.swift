//
//  ViewController.swift
//  Weather
//
//  Created by Armen Madoyan on 21.02.2023.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: UIView properties
    lazy var backgroundImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Light Background"))
        image.contentMode = .scaleAspectFill
        
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.textAlignment = .right
        textField.autocapitalizationType = .words
        textField.returnKeyType = .go
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemFill
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    //
    lazy var locationBatton: UIButton = {
        
        let button = UIButton(type: .system)
        button.contentMode = .scaleToFill
        button.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        button.tintColor = .black
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var searchButton: UIButton = {
        createButton(
            with: "magnifyingglass",
            and:UIAction { [unowned self] _ in
                dismiss(animated: true)
            }
        )
    }()
    
    lazy var uiStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 10
        stack.addArrangedSubview(locationBatton)
        stack.addArrangedSubview(textField)
        stack.addArrangedSubview(searchButton)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var conditionImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "cloud.rain"))
        image.contentMode = .scaleAspectFit
        image.heightAnchor.constraint(equalToConstant: 120).isActive = true
        image.widthAnchor.constraint(equalToConstant: 120).isActive = true
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var tempLabel: UILabel = {
        createLabel(with: "21", andSize: 80, weight: .black)
    }()
    
    lazy var separatorLabel: UILabel = {
        createLabel(with: "°", andSize: 100, weight: .light )
    }()
    
    lazy var degreeLabel: UILabel = {
        createLabel(with: "C", andSize: 100, weight: .light)
    }()
    
    lazy var cityNameLabel: UILabel = {
        createLabel(with: "London", andSize: 30, weight: .regular)
    }()
    
    lazy var tempStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 0
        stack.addArrangedSubview(tempLabel)
        stack.addArrangedSubview(separatorLabel)
        stack.addArrangedSubview(degreeLabel)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: ViewController Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        setupSubview(backgroundImage, uiStackView, conditionImageView, tempStackView, cityNameLabel)
        setConstraints()
    }
    
    
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Enter city name"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.textField.text = ""
    }
}

// MARK: UI
extension WeatherViewController {
    private func createButton(with systemName: String, and action: UIAction) -> UIButton {
        let button = UIButton(type: .system, primaryAction: action)
        button.contentMode = .scaleToFill
        button.setBackgroundImage(UIImage(systemName: systemName), for: .normal)
        button.tintColor = .black
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func createLabel(with title: String, andSize size: CGFloat, weight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.text = title
        label.font = .systemFont(ofSize: size, weight: weight)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func setupSubview(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate(
            [
                backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
                
                uiStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
                uiStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                uiStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                
                conditionImageView.topAnchor.constraint(equalTo: uiStackView.bottomAnchor, constant: 10),
                conditionImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
                
                tempStackView.topAnchor.constraint(equalTo: conditionImageView.bottomAnchor, constant: 10),
                tempStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                
                cityNameLabel.topAnchor.constraint(equalTo: tempStackView.bottomAnchor, constant: 10),
                cityNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            ]
        )
    }
}
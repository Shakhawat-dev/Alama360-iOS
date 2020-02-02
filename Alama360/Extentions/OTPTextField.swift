//
//  OTPTextField.swift
//  Alama360
//
//  Created by Alama360 on 08/06/1441 AH.
//  Copyright © 1441 Alama360. All rights reserved.
//

import UIKit

class OTPTextField: UITextField {
    
    var didEnterLastDigit: ((String) -> Void)?
    var defaultCharacter = "-"
    
    private var isConfigured = false
    private var digitLabels = [UILabel]()
    
    private lazy var tapRocognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(self, action: #selector(becomeFirstResponder))
        return recognizer
    }()

    func configure(with slotCount: Int = 4) {
        guard isConfigured == false else {
            return
        }
        isConfigured.toggle()
        
        configureTextField()
        
        let labelsStackView = createLabelsStackView(with: slotCount)
        addSubview(labelsStackView)
        
        addGestureRecognizer(tapRocognizer)
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: topAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configureTextField() {
        tintColor = .clear
        textColor = .clear
        keyboardType = .numberPad
        textContentType = .oneTimeCode
        
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        delegate = self
    }
    
    private func createLabelsStackView(with count: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.semanticContentAttribute = .forceLeftToRight
        
        for _ in 1 ... count {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 36)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 0.3219178082)
            label.isUserInteractionEnabled = true
            label.text = defaultCharacter
            
            stackView.addArrangedSubview(label)
            
            digitLabels.append(label)
        }
        
        return stackView
    }
    
    @objc
    private func textDidChange() {
        
        guard let text = self.text, text.count <= digitLabels.count else {
            return
        }
        
        for i in 0 ..< digitLabels.count {
            let currentLabel = digitLabels[i]
            
            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                currentLabel.text = String(text[index])
            } else {
                currentLabel.text = defaultCharacter
            }
        }
        
        if text.count == digitLabels.count {
            didEnterLastDigit?(text)
        }
        
    }

}

extension OTPTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let charecterCount = textField.text?.count else {return false}
        return charecterCount < digitLabels.count || string == ""
    }
}

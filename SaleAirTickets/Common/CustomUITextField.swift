//
//  CustomUITextField.swift
//  SaleAirTickets
//
//  Created by Kos on 05.06.2024.
//

import UIKit

final class CustomUITextField: UITextField {
    
    init(placeholder: String, fontSize: CGFloat, backgroundColor: UIColor, icon: UIImage?) {
        super.init(frame: .zero)
        commonInit(placeholder: placeholder, fontSize: fontSize, backgroundColor: backgroundColor, icon: icon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit(placeholder: "", fontSize: 16, backgroundColor: UIColor(), icon: nil )
    }
    
    private func commonInit(placeholder: String, fontSize: CGFloat, backgroundColor: UIColor , icon: UIImage?) {
        self.placeholder = placeholder
        font = .systemFont(ofSize: fontSize, weight: .regular)
        textColor = .white
        tintColor = .white
        self.backgroundColor = backgroundColor
        autocapitalizationType = .words
        autocorrectionType = .no
        keyboardType = .emailAddress
        returnKeyType = .done
        clearButtonMode = .never
        adjustsFontSizeToFitWidth = true
        delegate = self
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.customGray2]
        )
        if let icon = icon {
            let iconImageView = UIImageView(image: icon)
            iconImageView.contentMode = .scaleAspectFit
            leftView = iconImageView
            leftViewMode = .always
        }
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        clearButton.tintColor = .customGray2
        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        rightView = clearButton
        rightViewMode = .whileEditing
    }
    @objc private func clearText() {
        self.text = ""
    }
    
}

extension CustomUITextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: "абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ ")
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

}

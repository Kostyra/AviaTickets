//
//  CustomUITextField.swift
//  SaleAirTickets
//
//  Created by Kos on 05.06.2024.
//

import UIKit

final class CustomUITextField: UITextField {
    
    init(placeholder: String, fontSize: CGFloat, backgroundColor: UIColor) {
        super.init(frame: .zero)
        commonInit(placeholder: placeholder, fontSize: fontSize, backgroundColor: backgroundColor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit(placeholder: "", fontSize: 16, backgroundColor: UIColor() )
    }
    
    private func commonInit(placeholder: String, fontSize: CGFloat, backgroundColor: UIColor) {
        self.placeholder = placeholder
        font = .systemFont(ofSize: fontSize, weight: .regular)
        textColor = .white
        tintColor = .white
        self.backgroundColor = backgroundColor
        autocapitalizationType = .words
        autocorrectionType = .no
        keyboardType = .default
        returnKeyType = .done
        clearButtonMode = .whileEditing
        adjustsFontSizeToFitWidth = true
        delegate = self
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.customGray2]
        )
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

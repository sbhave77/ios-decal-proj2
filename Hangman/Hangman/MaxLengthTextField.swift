//
//  MaxLengthTextField.swift
//  Hangman
//
//  Created by Shreyas Bhave on 11/9/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
// TAKEN FROM: http://www.globalnerdy.com/2016/09/05/swift-3-text-field-magic-part-1-creating-text-fields-with-maximum-lengths/ 


import UIKit

class MaxLengthTextField: UITextField, UITextFieldDelegate {
    
    private var characterLimit: Int?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }
    
    @IBInspectable var maxLength: Int {
        get {
            guard let length = characterLimit else {
                return Int.max
            }
            return length
        }
        set {
            characterLimit = newValue
        }
    }
    
    // 1
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 2
        guard string.characters.count > 0 else {
            return true
        }
        
        // 3
        let currentText = textField.text ?? ""
        // 4
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        // 5
        return prospectiveText.characters.count <= maxLength
    }
    
}

//
//  ValidationField.swift
//  FormValidations
//
//  Created by Nickelfox on 31/03/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import UIKit
import QuartzCore

private var textFieldDidBegainEditingNotification = "UITextFieldTextDidBeginEditingNotification"
private var textFieldDidChangeNotification = "UITextFieldTextDidChangeNotification"
private var textFieldTextDidEndEditingNotification = "UITextFieldTextDidEndEditingNotification"

public class ValidationField: UITextField, ValidatableInput {
    public var error: String?
    public var validator: ValidationProtocol?
    public var isOptional = false
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    //MARK: Notification
    static let UITextFieldTextDidBeginEditingNotification = Notification.Name(textFieldDidBegainEditingNotification)
    static let UITextFieldTextDidChangeNotification = Notification.Name(textFieldDidChangeNotification)
    static let UITextFieldTextDidEndEditingNotification = Notification.Name(textFieldTextDidEndEditingNotification)
    
    func initialize() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleTextFieldDidBeginEditing) , name: ValidationField.UITextFieldTextDidBeginEditingNotification, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleTextFieldDidChange), name: ValidationField.UITextFieldTextDidChangeNotification, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleTextFieldDidEndEditing), name: ValidationField.UITextFieldTextDidEndEditingNotification, object: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public func validateField() -> (Bool, String?){
        if validator != nil {
            if let text = self.text {
                return self.validator?.validate(text) ?? (true, nil)
            }
        }
        return (false, nil)
    }
    
    public func validateInputSilently(){
        let (isValid, error) = validateField()
        self.error = error
        decorate(isValid)
    }
    
    //MARK: Helper Methods
    
    public func decorate(_ isValid: Bool?) {
        self.layer.borderWidth = 0.5
        guard let isValid = isValid else { self.layer.borderColor = UIColor.clear.cgColor; return }
        if isValid {
            self.layer.borderColor = UIColor.green.cgColor
        } else {
            self.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    func handleTextFieldDidBeginEditing(notification: NSNotification) {
        self.backgroundColor = .white
        self.decorate(nil)
    }
    
    func handleTextFieldDidChange(notification: NSNotification) {
        
    }
    
    func handleTextFieldDidEndEditing(notification: NSNotification) {
        self.backgroundColor = UIColor.lightGray
        self.validateInputSilently()
    }
}


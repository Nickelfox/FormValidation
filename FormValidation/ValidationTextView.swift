//
//  ValidationTextView.swift
//  FormValidation
//
//  Created by Abhishek on 03/07/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import UIKit

private var textViewDidBeginEditingNotification = "UITextViewTextDidBeginEditingNotification"
private var textViewDidChangeNotification = "UITextViewTextDidChangeNotification"
private var textViewTextDidEndEditingNotification = "UITextViewTextDidEndEditingNotification"

public class ValidationTextView: UITextView, ValidatableInput {
    
    public var inputText: String? {
        return self.text
    }
    
    public var error: String?
    public var validator: ValidationProtocol?
    public var isOptional = false
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    //MARK: Notification
    static let UITextViewTextDidBeginEditingNotification = Notification.Name(textViewDidBeginEditingNotification)
    static let UITextViewTextDidChangeNotification = Notification.Name(textViewDidChangeNotification)
    static let UITextViewTextDidEndEditingNotification = Notification.Name(textViewTextDidEndEditingNotification)

    func initialize() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleTextViewDidBeginEditing),
                                               name: ValidationTextView.UITextViewTextDidBeginEditingNotification,
                                               object: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleTextViewDidChange),
                                               name: ValidationTextView.UITextViewTextDidChangeNotification,
                                               object: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleTextViewDidEndEditing),
                                               name: ValidationTextView.UITextViewTextDidEndEditingNotification,
                                               object: self)
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
    
    func handleTextViewDidBeginEditing(notification: NSNotification) {
        self.backgroundColor = .white
        self.decorate(nil)
    }
    
    func handleTextViewDidChange(notification: NSNotification) {
        
    }
    
    func handleTextViewDidEndEditing(notification: NSNotification) {
        self.backgroundColor = UIColor.lightGray
        self.validateInputSilently()
    }
  
}

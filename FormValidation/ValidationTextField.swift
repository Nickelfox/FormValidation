//
//  ValidationTextField.swift
//  FormValidations
//
//  Created by Nickelfox on 31/03/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import UIKit
public class ValidationTextField: UITextField, ValidatableInput {
	public var inputText: String? {
		return self.text
	}
	var error: String?
	public var validator: ValidationProtocol?
	public var isOptional = false
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.delegate = self
	}
	
	func validateField() -> (Bool, String?) {
		guard let validator = self.validator, let text = self.text else { return (false, nil) }
		return validator.validate(text)
	}
	
	func validateSilently() {
		let (isValid, error) = validateField()
		self.error = error
		decorate(isValid)
	}
	
	private func decorate(_ isValid: Bool) {
		if self.validator == nil { return }
		self.layer.borderWidth = 0.5
		self.layer.borderColor = isValid ? UIColor.green.cgColor : UIColor.red.cgColor
	}
}

extension ValidationTextField: UITextFieldDelegate {
	public func textFieldDidEndEditing(_ textField: UITextField) {
		self.validateSilently()
	}
	public func textFieldDidBeginEditing(_ textField: UITextField) {
		self.layer.borderColor = UIColor.clear.cgColor
	}
}

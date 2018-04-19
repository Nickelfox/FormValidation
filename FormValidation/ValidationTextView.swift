//
//  ValidationTextView.swift
//  FormValidation
//
//  Created by Abhishek on 03/07/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import UIKit

class ValidationTextView: UITextView, ValidatableInput {
	var inputText: String? {
		return self.text
	}
	var error: String?
	var validator: ValidationProtocol?
	var isOptional = false
	
	required init?(coder aDecoder: NSCoder) {
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

extension ValidationTextView: UITextViewDelegate {
	func textViewDidEndEditing(_ textView: UITextView) {
		self.validateSilently()
	}
	func textViewDidBeginEditing(_ textView: UITextView) {
		self.layer.borderColor = UIColor.clear.cgColor
	}
}

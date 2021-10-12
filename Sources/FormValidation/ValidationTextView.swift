//
//  ValidationTextView.swift
//  FormValidation
//
//  Created by Abhishek on 03/07/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import UIKit

open class ValidationTextView: UITextView, ValidatableInput {
	public var inputText: String? {
		return self.text
	}
	var error: String?
	public var validator: ValidationProtocol?
	public var isOptional = false
    public var canDecorateBorder = true
	
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

extension ValidationTextView: UITextViewDelegate {
	public func textViewDidEndEditing(_ textView: UITextView) {
        if self.canDecorateBorder {
            self.validateSilently()
        }
	}
	public func textViewDidBeginEditing(_ textView: UITextView) {
        if self.canDecorateBorder {
            self.layer.borderColor = UIColor.clear.cgColor
        }
	}
}

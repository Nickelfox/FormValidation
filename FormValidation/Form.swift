//
//  Form.swift
//  FormValidations
//
//  Created by Vaibhav Parmar on 18/04/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation
import UIKit

public protocol ValidatableInput {
    var isOptional: Bool { get }
    var inputText: String? { get }
    var validator: ValidationProtocol? { get }
}

public class Form  {
    
    public init() { }
    
    public var inputs: [ValidatableInput] = []
    
    public func validate() -> (Bool, [String]) {
        var isValid = true
        var errors = [String]()
        for input in inputs {
            
            if !input.isOptional {
                if let text = input.inputText, let validator = input.validator {
                    let (valid, error) = canValidate(text: text, validator: validator)
                    if !valid, let err = error {
                        isValid = valid
                        errors.append(err)
                    }
                } else {
                    isValid = false
                    errors.append("Can't validate Empty String")
                }
            } else {
                if let text = input.inputText, let validator = input.validator, text.count > 0 {
                    let (valid, error) = canValidate(text: text, validator: validator)
                    if !valid, let err = error {
                        isValid = valid
                        errors.append(err)
                    }
                }
            }
        }
        return (isValid, errors)
    }

    func canValidate( text: String, validator: ValidationProtocol) -> (Bool, String?) {
        return validator.validate(text)
    }
}

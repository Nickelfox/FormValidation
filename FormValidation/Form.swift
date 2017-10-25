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
            if input.isOptional {
                let (valid, error) = canValidate(text: input.inputText, validator: input.validator)
                if !valid, let err = error {
                    isValid = valid
                    errors.append(err)
                }
            } else {
                let (valid, error) = canValidate(text: input.inputText, validator: input.validator)
                if !valid, let err = error {
                    isValid = valid
                    errors.append(err)
                }
            }
        }
        return (isValid, errors)
    }
    
    public func canValidate( text: String?, validator: ValidationProtocol?) -> (Bool, String?) {
        if let text = text, let validator = validator {
            return validator.validate(text)
        }
        return (false, nil)
    }
    
    
    //    func validate() -> (Bool, [String]) {
    //        var isValid = true
    //        var errors = [String]()
    //        for input in self.inputs {
    //            if input.isOptional {
    //                if let text = input.text {
    //                    if let validator = input.validator {
    //                        let (valid, error) = validator.validate(text)
    //                        if !valid {
    //                            isValid = false
    //                            if let err = error {
    //                                errors.append(err)
    //                            }
    //                        }
    //                    }
    //                }
    //            } else {
    //                if let text = input.text {
    //                    if let validator = input.validator {
    //                        let (valid, error) = validator.validate(text)
    //                        if !valid {
    //                            isValid = false
    //                            if let err = error {
    //                                errors.append(err)
    //                            }
    //                        }
    //                    }
    //                } else {
    //                    isValid = false
    //                    errors.append("Empty field")
    //                    // Field is empty
    //                }
    //            }
    //        }
    //        return (isValid, errors)
    //    }
    
}

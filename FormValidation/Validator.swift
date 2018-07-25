//
//  Validator.swift
//  FormValidations
//
//  Created by Vaibhav Parmar on 15/04/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation

private let emptyStringError = "Value Required"
private let firstNameError = "First Name Required"
private let lastNameError = "Last Name Required"
private let fullNameError = "First Name and Last Name Required"
private let nameRequiredError = "Invalid Name"
private let emailError = "Invalid Email"
private let phoneError = "Invalid Phone"
private let alphaNumericError = "Alpha Numeric Value Required"
private let urlError = "Invalid URL"
private let passwordError = "Password must be Alpha Numeric of atleast 8 characters"
private let pincodeError = "Invalid PIN Code"
private let ccExpiryError = "Credit Card Expired"
private let ccNumberError = "Invalid Credit Card Number"
private let ccVerificationError = "Invalid Credit Card Verification Number"

public protocol ValidationProtocol {
    func validate(_ value: String) -> (Bool, String?)
}

public class EmptyValidator: ValidationProtocol {
    
    public init() { }
    
    public func validate(_ value: String) -> (Bool, String?) {
        if !value.isEmpty {
            return (true, nil)
        }
        return (false, emptyStringError)
    }
}

public class FullNameValidator: ValidationProtocol {
    
    public init() { }
    
    public func validate(_ value: String) -> (Bool, String?) {
        if !value.isAlphabetic {
            return (false, nameRequiredError)
        }
        let name: [String] = value.components(separatedBy: " ")
        if name.count == 2 && name[1].count > 1 {
            return (true, nil)
        }
        return (false, fullNameError)
    }
}

public class FirstNameValidator: ValidationProtocol {
    
    public init() { }
    
    public func validate(_ value: String) -> (Bool, String?) {
        if value.isAlphabetic {
           return (true, nil)
        }
            return (false, nameRequiredError)
    }
}

public class LastNameValidator: ValidationProtocol {
    
    public init() { }
    
    public func validate(_ value: String) -> (Bool, String?) {
        if value.isAlphabetic {
            return (true, nil)
        }
        return (false, nameRequiredError)
    }
}

public class EmailValidator: ValidationProtocol {
    
    public init() { }
    
    public func validate(_ value: String) -> (Bool, String?) {
        if value.isValidEmail {
            return (true, nil)
        }
        return (false, emailError)
    }
}

public class PhoneValidator: ValidationProtocol {
    
    public init() { }
    
    public func validate(_ value: String) -> (Bool, String?) {
        if value.isValidPhone {
            return (true, nil)
        }
        return (false, phoneError)
    }
}

public class AlphaNumericValidator: ValidationProtocol {
    
    public init() { }
    
    public func validate(_ value: String) -> (Bool, String?) {
        if value.isAlphaNumeric {
            return (true, nil)
        }
        return (false, alphaNumericError)
    }
}

public class UrlValidator: ValidationProtocol {
    
    public init() { }
    
    public func validate(_ value: String) -> (Bool, String?) {
        if value.isValidURL {
            return (true, nil)
        }
        return (false,  urlError)
    }
}

public class PasswordValidator: ValidationProtocol {
    
    public init() { }
    
    public func validate(_ value: String) -> (Bool, String?) {
        if value.isValidPassword {
            return (true, nil)
        }
        return (false, passwordError)
    }
}

public class PinCodeValidator: ValidationProtocol {
    
    public init() { }
    
    public func validate(_ value: String) -> (Bool, String?) {
        if value.isValidPinCode {
            return (true, nil)
        }
        return (false, pincodeError)
    }
}

public class CCExpiryDateValidator: ValidationProtocol {
    
    public init() { }
    
    public func validate(_ value: String) -> (Bool, String?) {
        if value.isValidCreditCardExpirationDate {
            return (true, nil)
        }
        return (false, ccExpiryError)
    }
}

public class CCNumberValidator: ValidationProtocol {
    
    public init() { }
    
    public func validate(_ value: String) -> (Bool, String?) {
        if value.isValidCreditCardNumber {
            return (true, nil)
        }
        return (false, ccNumberError)
    }
}

public class CCVerificationCodeValidator: ValidationProtocol {
    
    public init() { }
    
    public func validate(_ value: String) -> (Bool, String?) {
        if value.isValidCardVerificationCode {
            return (true, nil)
        }
        return (false, ccVerificationError)
    }
}

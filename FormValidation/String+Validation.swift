//
//  String + Validation.swift
//  FormValidations
//
//  Created by Vaibhav Parmar on 14/04/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation

private let alphabeticRegx = "^[A-z ]+$"
private let alphaNumericRegx = "[a-zA-Z0-9]+$"
private let numericRegx = "[0-9]+$"
private let emailRegx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
private let phoneRegx = "^\\d{10}$"
private let passwordRegx = "^(?=.*?[A-z]).{8,}$"
private let pinCodeRegx = "\\d{6}"

extension String {
    
    public var isAlphabetic: Bool {
        if !isEmpty {
            let alphabeticTest = NSPredicate(format: "SELF MATCHES %@", alphabeticRegx)
            return alphabeticTest.evaluate(with:self)
        }
        return false
    }
    
    public var isNumeric: Bool {
        if !isEmpty {
            let numericTest = NSPredicate(format: "SELF MATCHES %@", numericRegx)
            return numericTest.evaluate(with: self)
        }
        return false
    }
    
    public var isAlphaNumeric: Bool {
        if !isEmpty {
            let alphaNumericTest = NSPredicate(format: "SELF MATCHES %@", alphaNumericRegx)
            return alphaNumericTest.evaluate(with: self)
        }
        return false
    }

    public var isValidEmail: Bool {
        if !isEmpty {
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegx)
            return emailTest.evaluate(with: self)
        }
        return false
    }
    
    public var isValidURL: Bool {
        if !isEmpty {
            let url: URL = URL(fileURLWithPath: self)
            if let _ = url.scheme, let _ = url.host {
                return true
            }
        }
        return true
    }

    public var isValidPassword: Bool {
        if !isEmpty {
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegx)
            return passwordTest.evaluate(with: self)
        }
        return false
    }
    
    public var isValidPhone: Bool {
        if !isEmpty {
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegx)
            return phoneTest.evaluate(with: self)
        }
        return false
    }
    
    public var isValidPinCode: Bool {
        if !isEmpty {
            let pinCodeTest = NSPredicate(format: "SELF MATCHES %@", pinCodeRegx)
            return pinCodeTest.evaluate(with: self)
        }
        return false
    }
    
    public var isValidCreditCardExpirationDate: Bool {
        if self.count < 4 {
            return false
        }
        let slashIndex: NSRange = (self as NSString).range(of: "/")
        if slashIndex.location == 0 {
            return false
        }
        let monthString: String = self.components(separatedBy: "/")[0]
        let yearString: String = self.components(separatedBy: "/")[1]
        if monthString.count < 0 || yearString.count < 0 {
            return false
        }
        if let month = Int(monthString), var year = Int(yearString) {
            let currentYear: Int = Calendar.current.component(.year, from: Date())
            let currentMonth: Int = Calendar.current.component(.month, from: Date())
            if yearString.count <= 2 {
                year += 2000
            }
            if year == currentYear {
                return ((month >= currentMonth) && (month <= 12) && (month != 0))
            }
            return ((year >= currentYear) && (month <= 12) && (month != 0))
        }
        return true
    }
    
    public var isValidCreditCardNumber: Bool {
        if digitString.count < 12 || digitString.count > 20 {
            return false
        }
        var index: Int = 0
        var oddSum: Int = 0
        var evenSum: Int = 0
        for char in digitString.reversed() {
            index += 1
            if let intChar = Int(String(char)) {
                if index % 2 != 0 {
                    oddSum += intChar
                } else {
                    let doubledValue = intChar * 2
                    evenSum += digitSum(digit: doubledValue)
                }
            }
        }
        if (oddSum+evenSum) % 10 == 0 {
            return true
        }
        return false
    }
    
    public var isValidCardVerificationCode: Bool {
        let digitString = self.digitString
        let digitStringLength = digitString.count
        if (self.count == digitStringLength) && (digitStringLength == 3 || digitStringLength == 4) {
            return true
        }
        return false
    }
    
    public var digitString: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
}

//MARK: Helper Methods

func digitSum( digit: Int) -> Int {
    var digit = digit
    var sum = 0
    while digit > 0 {
        sum += digit % 10
        digit = digit/10
    }
    return sum
}


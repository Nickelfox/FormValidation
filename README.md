[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/Nickelfox/FormValidation/blob/master/LICENSE.md)
![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)


FormValidation
============
**Form Validation** validates user input of `text fields` and `text views` in obvious way.

Features
------------
 - Use *ValidationTextField* or *ValidationTextView* instead of *UITextField* or *UITextView*.
 - Validation Rules:
	 - Validate all the textFields/textViews in form at once, by passing validator for each textFiled/textView or validate input of each individually.
 - Decorates the textField/textView for valid or invalid input. 
 - Payment cards are Luhn Verified. 
 - Extensive code documentation.

Installation
------------------
#### <i class="icon-file"></i>**CocoaPods**
[CocoaPods](https://cocoapods.org) is the dependency manager for Cocoa Libraries. You can install Cocoapods using following command:

> `$ sudo gem install cocoapods`

If you wish to integrate FormValidator in your project, the make following changes in your `Podfile`:

    source 'https://github.com/Nickelfox/FormValidation.git'
    platform :ios, '9.0'
    use_frameworks!
    pod 'FLFormValidator', '~> 1.0'
After saving `Podfile`. Run following command:

    pod install

#### <i class="icon-pencil"></I>**Manually**
If you don't want to use any dependency manager in your project, you can install this library manually too.
Just add the following lines to your `Podfile`:

    pod "FormValidation", :git => 'https://github.com/Nickelfox/FLUtilities.git'

After saving Podfile, run following:

     pod install

Usage
---------
The core component of FormValidator is `ValidationProtocol`.

**`ValidatableInput`**

This protocol comprises of three variables.
`isOptional` of type `Bool`
`inputText` of type `String`
`validator` of type `ValidationProtocol`

**`ValidationProtocol`**

```swift

    protocol ValidationProtocol {
        func validate(_ value: String) -> (Bool, String?)
    }
```
This protocol is conformed by class.

```swift
    class NameValidator: ValidationProtocol {
            func validate(_ value: String) -> (Bool, String?) {
    	        return value.isAlphabetic ? (true, nil) : (false, "error")
    	    }
    }
```


 **`Form`**

 
 `Form` class takes array of `ValidatableInput` as input.
 Method `validate` of class `Form` returns a tuple `(bool, String)`. If the input of elements of array are valid, then it returns `(true, nil)` else `(false, "error")`.
 
**`ValidationTextField`**

`ValidationTextField` or `ValidationTextView` can be use instead of `UITextField` and `UITextView`. `ValidationTextField` and `ValidationTextView` are subclass of `UITextField` and `UITextView` respectively.

```swift
    @IBOutlet var nameTextField: ValidationTextField!
    
    let form = Form()
    
    override func viewDidLoad() {
		super.viewDidLoad()
		nameTextField.validator = NameValidator()
		form.inputs = [nameTextField]
	}
	
	@IBAction func handleValidationTapped(_ sender: Any) {
		let (isValid, errors) = form.validate()
		if isValid {
			// Cool ya! submit the form
		} else {
			// Eww! notify errors
		}
	}
```
**`extension String`**

All the validation type are written in this extension.

```swift
    private let alphabeticRegx = "^[A-z ]+$"
     var isAlphabetic: Bool {
            if !isEmpty {
                let alphabeticTest = NSPredicate(format: "SELF MATCHES %@", alphabeticRegx)
                return alphabeticTest.evaluate(with:self)
            }
            return false
        }
```

**Validating input of individual textField/textView**

```swift
    if textField.text.isAlphabetic {
    	// 👍 valid input
    } else {
    	// hmm! 😒 wrong input
    }
```

Example
-----------
Detailed example is there in Demo Directory.

Want to Contribute ?
-----------------------------

 - Fork it 
 - Create your feature branch `git checkout -b my-new-feature`
 - Commit your changes `git commit -am 'Add some feature'`
 - Push to the branch `git push origin my-new-feature`  
 - Create a new Pull Request





Pod::Spec.new do |s|



  s.name         = "FieldValidation"
  s.version      = "1.0.2"
  s.summary      = "FieldValidation"
  s.description  = "FieldValidation is a form validation while submiiting signup/login info."
  s.homepage     = "https://github.com/Nickelfox/form-validation-ios"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Abhishek Thapliyal" => "abhishek@nickelfox.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/Nickelfox/form-validation-ios.git", :tag => "#{s.version}" }
  s.source_files  = "FieldValidation", "FieldValidation/**/*.{swift}"
  s.requires_arc = true

end

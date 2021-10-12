
Pod::Spec.new do |s|

  s.name         = "FormValidation"
  s.version      = "1.0.3"
  s.summary      = "FormValidation"
  s.description  = "FormValidation is a form validation while submiiting signup/login info."
  s.homepage     = "https://github.com/Nickelfox/FormValidation"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Abhishek Thapliyal" => "abhishek@nickelfox.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/Nickelfox/FormValidation.git", :tag => "#{s.version}" }
  s.source_files = 'Sources/**/*'
  s.requires_arc = true

end

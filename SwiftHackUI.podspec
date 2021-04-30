Pod::Spec.new do |spec|

  spec.name         = "SwiftHackUI"
  spec.version      = "0.0.7"
  spec.summary      = "A CocoaPods library written in Swift to handle UI components as RadioBox, CircleButton, Calendar, and more."
  
  spec.description  = <<-DESC
  This CocoaPods library written in Swift helps to build the UI using built-in components as RadioBox, CircleButton, Calendar, and more.
                   DESC

  spec.homepage     = "https://github.com/5nilha/SwiftHackUI"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Fabio" => "bwtdirect@gmail.com" }

  spec.ios.deployment_target = "14.4"
  spec.swift_version = "5.0"
  spec.source       = { :git => "https://github.com/5nilha/SwiftHackUI.git", :tag => "#{spec.version}" }
  spec.source_files  = "SwiftHackUI/**/*.{h,m,swift}"

end
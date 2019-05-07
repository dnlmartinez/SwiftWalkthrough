Pod::Spec.new do |s|
  s.name             = 'SwiftWalkthrough'
  s.version          = '1.0.0'
  s.summary          = 'Simple semi modal presentation WalkThrough'
  s.description      = 'SwiftWalkthrough is a semi modal presentation Walkthrought'
  
  s.homepage         = 'https://github.com/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Martinez' => 'dmg241082@gmail.com' }
  s.source           = { :git => 'https://github.com/danymg/', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.swift_version = '4.0'

  s.source_files  = "SwiftWalkthrough", "SwiftWalkthrough/**/*.{swift}"

  s.resources = "SwiftWalkthrough/**/*.{xib,png}"

end

Pod::Spec.new do |s|
  s.name         = "SwiftScan"
  s.version      = "1.0.0"
  s.summary      = "qr and bar codes scan lib"


  s.homepage     = "https://github.com/sereja93/SwiftScan"
  s.license      = "MIT"
  s.authors      = "s.ivanov"
  s.ios.deployment_target = "12.0"
  s.source       = { :git => "https://github.com/sereja93/SwiftScan.git", :tag => "1.2.2" }
  s.source_files  = "SwiftScanner"

  s.swift_versions = ['4.0', '4.2', '5.0', '5.1']
end

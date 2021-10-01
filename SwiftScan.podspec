Pod::Spec.new do |s|
  s.name         = "SwiftScan"
  s.version      = "1.0.0"
  s.summary      = "qr and bar codes scan lib"


  s.homepage     = "https://github.com/sereja93/SwiftScan"
  s.license      = "MIT"
  s.authors      = "s.ivanov"
  s.source       = { :git => "https://github.com/sereja93/SwiftScan.git", :tag => "1.2.2" }
  s.source_files = "SwiftScanner/**/*.{swift,h}"
  s.platform     = :ios, "12.0"
  s.requires_arc = true
  s.swift_versions = '5.0'
end

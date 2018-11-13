#
#  Be sure to run `pod spec lint XXAuthorizationKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

    s.name         = "XXAuthorizationKit"
    s.version      = "1.0.0"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.summary      = "AuthorizationKit for develop"

    s.homepage     = "https://github.com/hanson1024/XXAuthorizationKit"
    s.source       = { :git => "https://github.com/hanson1024/XXAuthorizationKit.git", :tag => s.version }
    s.source_files = "XXAuthorizationKit/**/*.{h,m}"
    s.requires_arc = true
    s.platform     = :ios, "8.0"

    # User
    s.author       = { "hanson" => "luoshuaihome@gmail.com" }

end

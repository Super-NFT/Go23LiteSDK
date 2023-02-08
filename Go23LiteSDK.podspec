#
# Be sure to run `pod lib lint Go23LiteSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Go23LiteSDK'
  s.version          = '0.3.0'
  s.summary          = 'A short description of Go23LiteSDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Super-NFT/Go23LiteSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ming.lu' => 'ming.lu@coins.ph' }
  s.source           = { :git => 'https://github.com/Super-NFT/Go23LiteSDK.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.static_framework = true
#  s.requires_arc = true
#  s.xcconfig = {'OTHER_LDFLAGS' => '-ObjC'}
  s.pod_target_xcconfig = {
      'OTHER_LDFLAGS' => ['-lObjC'] ,
      'VALID_ARCHS[sdk=iphonesimulator*]' => '' }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.source_files = 'Go23LiteSDK/Classes/**/*.{swift}'
  s.swift_version = '5.0'

   s.resource_bundles = {
     'Go23_Go23LiteSDK' => ['Go23LiteSDK/Assets/*.gif','Go23LiteSDK/Assets/Images.xcassets']
   }
   
   s.vendored_frameworks = ['Go23LiteSDK/Classes/Frameworks/Client.xcframework','Go23LiteSDK/Classes/Frameworks/Go23SDK.framework']
#   s.dependency 'IQKeyboardManager'
#   s.dependency 'Alamofire','4.9.1'
#   s.dependency 'SDWebImage'
#   s.dependency 'SDWebImageWebPCoder'
#   s.dependency 'BigInt'
#   s.dependency 'SnapKit'
   s.dependency 'IQKeyboardManagerSwift'
   s.dependency 'Kingfisher'
   s.dependency 'MJRefresh', '3.7.2'
   s.dependency 'FDFullscreenPopGesture'
   
end

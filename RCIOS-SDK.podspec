#
# Be sure to run `pod lib lint RCIOS-SDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RCIOS-SDK'
  s.version          = '1.0.0'
  s.summary          = 'UI方面组件 RCIOS-SDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'git@github.com:RichChane/RCIOS-SDK.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rich' => '314112759@qq.com' }
  s.source           = { :git => 'git@github.com:RichChane/RCIOS-SDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = '{RCIOS-SDK/GeneralCore,RCIOS-SDK/KitCategry,RCIOS-SDK/PickerView,RCIOS-SDK/PopView,RCIOS-SDK/TempModel,RCIOS-SDK/UIFactory,RCIOS-SDK/Widget}{/}**/*','RCIOS-SDK/RCSDKHeader.h','RCIOS-SDK/BaseData.h'
  
  # s.resource_bundles = {
  #   'RCIOS-SDK' => ['RCIOS-SDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
#s.dependency 'OSFoundation'
#s.dependency 'SDWebImage'
#s.dependency "GPUImage"
#s.dependency "ZLPhotoBrowser"         # 相册 (包含sdweb)
#s.dependency "pop", '~> 1.0'
#s.dependency 'MJRefresh'
#s.dependency 'MBProgressHUD'
#  s.dependency 'YYKit'
#s.dependency 'YYCategories'

#s.pod_target_xcconfig = {
    # This is needed by all pods that depend on Protobuf:
#  'GCC_PREPROCESSOR_DEFINITIONS' => 'ssdfsdfsdf=1',
# }
end

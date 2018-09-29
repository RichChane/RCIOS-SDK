# RCIOS-SDK
一个ios项目中常用的控件、工具、功能


使用方法：
Podfile内容换成
source 'https://github.com/RichChane/RCIOS-SDK.git'
source'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'

target 'Demo_RCSDK' do
    
    pod 'RCIOS-SDK',:git => 'https://github.com/RichChane/RCIOS-SDK.git',:branch => 'developer'
    
end


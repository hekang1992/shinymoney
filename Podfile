source 'https://github.com/CocoaPods/Specs.git'
platform :ios, "12.2"
use_frameworks!

target "ShinyMoney" do

pod 'Masonry'

pod 'Alamofire'

pod 'SwiftyJSON'

pod 'MBProgressHUD'

pod 'ReactiveObjC'

pod 'Kingfisher'

pod 'Hue'

pod 'Kingfisher'

pod 'IQKeyboardManagerSwift'

pod 'TTTAttributedLabel'

pod 'SAMKeychain'

pod 'AppsFlyerFramework'

pod 'NNModule-swift/URLRouter'

pod 'SDCycleScrollView'

pod 'MJRefresh'

pod 'AAINetwork', :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-libraries/AAINetwork/AAINetwork-V1.0.0.tar.bz2', type: :tbz

pod 'AAILiveness', :http => 'https://prod-guardian-cv.oss-ap-southeast-5.aliyuncs.com/sdk/iOS-liveness-detection/2.0.6/iOS-Liveness-SDK-V2.0.6.tar.bz2', type: :tbz

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "12.2"
    end
  end
end

end

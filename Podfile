platform :ios, '13.0'
inhibit_all_warnings!
use_frameworks!

workspace 'SquareChallenge'

def shared_pods
  pod 'PromiseKit', '6.10.0'
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'SDWebImage', '5.2.1'
  pod 'SwiftLint'
end

target 'AGViperKit' do
  project 'AGViperKit/AGViperKit.xcodeproj'
  shared_pods

  target 'AGViperKitTests' do
    inherit! :search_paths
    shared_pods
  end
end

target 'SquareChallenge' do
  project 'SquareChallenge/SquareChallenge.xcodeproj'
  shared_pods

  target 'SquareChallengeTests' do
    inherit! :search_paths
    shared_pods
  end
end

# To inhibit pods related warnings
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'ARCHS'
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end

platform :ios, '9.0'

workspace 'TeamupKit'

use_frameworks!

def shared_pods

    pod 'KeychainSwift', '~> 8.0'
    pod 'Alamofire', '~> 4.5'
end

target 'TeamupKit' do
  project './Sources/TeamupKit.xcodeproj'
  target 'TeamupKitTests'

  shared_pods
end

target 'TeamupKit-Example' do
  project './Example/TeamupKit-Example.xcodeproj'

  shared_pods
end
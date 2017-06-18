platform :ios, '9.0'

workspace 'TeamupKit'

use_frameworks!

def shared_pods

    pod 'KeychainSwift'

end

target 'TeamupKit' do
  project './Sources/TeamupKit.xcodeproj'
  workspace 'TeamupKit'
  target 'TeamupKitTests'

  shared_pods
end

target 'TeamupKit-Example' do
  project './Example/TeamupKit-Example.xcodeproj'
  workspace 'TeamupKit'

  shared_pods
end
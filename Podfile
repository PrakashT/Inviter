# Uncomment the next line to define a global platform for your project
# platform :ios, '11.0'

use_frameworks!

def shared
    pod 'Alamofire'
    pod 'SwiftyJSON'
    pod 'SDWebImage'
    pod 'MBProgressHUD'
    
    pod 'Firebase/Core'
    pod 'Firebase/Messaging'
    
    pod 'Fabric'
    pod 'Crashlytics'
    
    pod 'FBSDKLoginKit'
    #pod 'Facebook-iOS-SDK'
    pod 'FacebookCore'
    
    pod 'GoogleSignIn'
end

target 'Inviter' do
    shared
end

target 'Inviter Test' do
    shared
end
  
  target 'InviterTests' do
      inherit! :search_paths
      # Pods for testing
  end

  target 'InviterUITests' do
    inherit! :search_paths
    # Pods for testing
  end


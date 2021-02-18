# Uncomment the next line to define a global platform for your project
platform :ios, '14.2'

post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.2'
  end
 end
end

target 'monofin_mvp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for monofin_mvp
        pod 'JTAppleCalendar'
        pod 'Firebase/Analytics'
        pod 'FlagPhoneNumber'
        pod 'Firebase'
        pod 'Firebase/Auth'
        pod 'FirebaseFirestoreSwift'
	pod 'Firebase/Storage'
  target 'monofin_mvpTests' do
    inherit! :search_paths
    # Pods for testing
        pod 'JTAppleCalendar'
        pod 'Firebase/Analytics'
        pod 'FlagPhoneNumber'
        pod 'Firebase'
        pod 'Firebase/Auth'
        pod 'FirebaseFirestoreSwift'
	pod 'Firebase/Storage'
  end

  target 'monofin_mvpUITests' do
    # Pods for testing
        pod 'JTAppleCalendar'
  end

end


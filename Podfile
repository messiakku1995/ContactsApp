# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ConnectsApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ConnectsApp
pod 'Alamofire', '5.5.0'
  pod 'SkyFloatingLabelTextField'
  pod 'IHProgressHUD'
  pod 'IQKeyboardManagerSwift'
  pod 'Kingfisher', '~> 7.0'

end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end

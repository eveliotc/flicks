platform :ios, '9.3'
use_frameworks!

target 'Flicks' do
pod 'Alamofire', '~> 4.0'
pod 'AlamofireImage', '~> 3.1'
pod 'ModelMapper', '~> 5.0'
pod 'MBProgressHUD', '~> 1.0'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end

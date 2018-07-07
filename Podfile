# Uncomment the next line to define a global platform for your project
platform :ios, '11.4'

target 'perx2' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!



  # Pods for perx2


pod 'SideMenu'
pod 'TTGEmojiRate'
pod 'CollectionViewSlantedLayout'
pod 'Alamofire', '~> 4.7'
pod 'AlamofireImage'
pod 'GoogleMaps'
pod 'GooglePlaces'
pod 'SwiftyJSON'
pod 'GooglePlacePicker'
pod 'ElongationPreview'
pod 'Firebase/Database'
pod 'NVActivityIndicatorView'
#pod 'VegaScrollFlowLayout'
pod 'FoldingCell'
pod 'ChameleonFramework'
pod 'ProgressMeter'
pod 'OpenLocate'
pod 'UICircularProgressRing'
post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end end
end

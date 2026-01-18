platform :ios, '15.0'

source 'https://github.com/CocoaPods/Specs.git'

# My own Core PodSpecs Git Repo
source 'https://github.com/Yesferal/HornsApp-PodSpecs.git'

abstract_target 'SharedPods' do
    # HornsApp-specific pods
    #pod 'HornsAppCore', '~> 1.4.4'
    pod 'HornsAppCore', :path => '../../Kotlin/HornsApp-Core'
    
    # Third party pods
    pod 'Alamofire', '~> 5.10.2'
    
    # App 1
    target 'HornsApp'
    
    # App 2
    target 'MuvinApp'
end

platform :ios, '17.0'

source 'https://github.com/CocoaPods/Specs.git'

# My own Core PodSpecs Git Repo
source 'https://github.com/Yesferal/HornsApp-PodSpecs.git'

abstract_target 'SharedPods' do
    # HornsApp-specific pods
    # Local path while developing GetRelatedConcertsUseCase (#feat-2). Switch back to '~> 1.6.0' after publish.
    #pod 'HornsAppCore', '~> 1.5.0'
    pod 'HornsAppCore', :path => '../HornsApp-Core'
    
    # Third party pods
    pod 'Alamofire', '~> 5.10.2'
    
    # App 1
    target 'HornsApp'
    
    # App 2
    target 'MuvinApp'
end

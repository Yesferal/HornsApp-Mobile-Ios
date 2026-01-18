# Horns App - iOS Module
This is the hornsapp ios app module published in the appstore.

## How to build
Update the pod file just in case
```
pod update
```
Install all the dependencies
```
pod install
```

### Core Podspec Lib
The `HornsAppCore.podspec` file contains the description of our library. 
This file will first execute a script in order to build a xcframework.
This version will be published in our [HornsApp-PodSpecs Repository](https://github.com/Yesferal/HornsApp-PodSpecs)

## How to create a new version
### Targets
This project has two targets due to we need both apps to be publish in the app store using different data, icon and colors
#### App 1
```
target 'HornsApp'
```
    
#### App 2
```
target 'MuvinApp'
```

## License
```
Copyright 2025 HornsApp Contributors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

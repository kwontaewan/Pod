# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def testing
  pod 'Quick'
  pod 'Nimble'
  pod 'RxTest'
  pod 'RxBlocking'
end

target 'Pod' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Pod
  pod 'Kingfisher'

  # Rx
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxSwiftExt', '~> 5'
  pod 'RxViewController'
  pod "RxRealm"
  pod "RealmSwift"

  #Logging
  pod 'CocoaLumberjack/Swift'
  pod 'Then'
  
  #Lint
  pod 'SwiftLint'
  
  #HTML Parser
  pod 'SwiftSoup'
    
  #Firebase
  pod 'Firebase/Analytics'
  pod 'RxFirebase/Firestore'
  pod 'Firebase/Firestore'
  pod 'Firebase/Auth'
  pod 'Firebase/Messaging'
  
  #UI
  pod "Koloda"
  pod 'SnapKit', '~> 5.0.0'
  pod 'PanModal'
  
  target 'PodTests' do
    inherit! :search_paths
    testing
  end

  target 'PodUITests' do

  end

end

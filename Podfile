# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def testing_pods
    pod 'Quick'
    pod 'Nimble'
end

workspace 'Reduxulous.xcworkspace'


target 'Movielicuos' do
  project 'Examples/Movielicuos/Movielicuos.xcodeproj'
  use_frameworks!
  target 'MovielicuosTests' do
    # Pods for testing
    testing_pods
  end
end


target 'Reduxulous' do
  project 'Reduxulous.xcodeproj'
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Reduxulous

  target 'ReduxulousTests' do
    # Pods for testing
    testing_pods	
  end

end

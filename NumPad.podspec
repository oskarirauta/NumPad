Pod::Spec.new do |s|
  s.name             = 'NumPad'
  s.version          = '1.3.1'
  s.license          = { :type => 'Free', :text => 'Free' }
  s.summary          = 'NumPad keyboard framework for iOS. For both, iPhone and iPad. Swift 4.0'
 
  s.description      = <<-DESC
NumPad and DoneBar inputview helpers. Compatible with both, iPhone and iPad.
                       DESC
 
  s.homepage         = 'https://github.com/oskarirauta/NumPad'
  s.author           = { 'Oskari Rauta' => 'oskari.rauta@gmail.com' }
  s.source           = { :git => 'https://github.com/oskarirauta/NumPad.git', :tag => s.version.to_s }

  s.swift_version = '4.0' 
  s.ios.deployment_target = '11.0'
  s.source_files = 'NumPad/NumPad/Types/*.swift', 'NumPad/NumPad/Extensions/*.swift', 'NumPad/NumPad/Classes/*.swift'
  s.resources = [ 'NumPad/NumPad/Resources/NumPad.xcassets' ]
  s.dependency 'CommonKit'
 
end

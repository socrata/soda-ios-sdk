Pod::Spec.new do |s|
     s.name     = 'SODAClient'
     s.version  = '1.0.0'
     s.license  = 'Apache License, Version 2.0'
     s.summary  = 'An iOS Client for the SODA 2.0 API'
     s.homepage = 'https://github.com/socrata/soda-ios-sdk'
     s.authors  = { 'Socrata' => 'http://dev.socrata.com', '47 Degrees' => 'http://47deg.com' }
     s.source   = { :git => 'https://github.com/socrata/soda-ios-sdk.git', :tag => '1.0.0' }
     s.source_files = 'SODAClient'
     s.requires_arc = true
     s.ios.deployment_target = '5.0'
     s.dependency = 'AFNetworking', '>= 1.2.0'
     s.ios.frameworks = 'MobileCoreServices', 'SystemConfiguration', 'Security', 'MapKit', 'CoreLocation'
end
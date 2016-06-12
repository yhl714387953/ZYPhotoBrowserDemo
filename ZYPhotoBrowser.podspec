Pod::Spec.new do |s|
　　s.name = "ZYPhotoBroser"
　　s.version = “1.0.0”
　　s.summary = '嘴爷简单封装的网络照片查看器'
　　s.homepage = "https://github.com/yhl714387953/ZYPhotoBrowserDemo"
　　s.license = 'MIT'
　　s.author = { “ZuiYe” => “hailing.yu@zhongkeyun.com” }
　　s.source = { :git => "https://github.com/yhl714387953/ZYPhotoBrowserDemo.git", :tag => "#{s.version}"}
　　s.platform = :ios
　　s.source_files = 'CBPhotoPicker/**/*.{h, m}'
　　s.resources = "ZYPhotoBroser/**/*.png"
　　s.framework = 'QuartzCore'
　　s.dependency 'JSONKit', '~> 1.4'
　　end
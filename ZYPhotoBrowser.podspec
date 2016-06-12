Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '8.0'
s.name = “ZYPhotoBroser”
s.summary = “嘴爷简单封装的网络照片查看器”
s.requires_arc = true

# 2
s.version = “1.0.0”

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { “ZuiYe” => “hailing.yu@zhongkeyun.com” }

# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://github.com/yhl714387953/ZYPhotoBrowserDemo"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/yhl714387953/ZYPhotoBrowserDemo.git", :tag => "#{s.version}"}


# 7
s.framework = "UIKit"

# 8
s.source_files = "CBPhotoPicker/**/*.{h, m}”

# 9
s.resources = "CBPhotoPicker/**/*.{png,jpeg,jpg,storyboard,xib}"
end
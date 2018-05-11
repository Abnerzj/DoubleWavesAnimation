Pod::Spec.new do |s|
s.name         = "ZJWavesView"
s.version      = "1.0.0"
s.summary      = "Package similar to Taobao wave oscillation animation view."
s.description  = <<-DESC
封装类似淘宝等双波浪震荡动画视图(Package similar to Taobao wave oscillation animation view.).
DESC
s.homepage     = "https://github.com/Abnerzj/ZJWavesView"
# s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "Abnerzj" => "Abnerzj@163.com" }
s.social_media_url   = "http://weibo.com/ioszj"
s.platform     = :ios, "7.0"
s.source       = { :git => "https://github.com/Abnerzj/ZJWavesView.git", :tag => "#{s.version}" }
s.source_files  = "ZJWavesView/ZJWavesView/ZJWavesView/*.{h,m}"
s.requires_arc = true
end


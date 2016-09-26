Pod::Spec.new do |s|
  s.name         = "Pontus"
  s.version      = "0.0.5"
  s.summary      = "My own iOS development kit, written by Swift."
  s.homepage     = "https://github.com/zhangzichen/Pontus"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "zhangzichen" => "1015947235@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/zhangzichen/Pontus.git", :tag => "0.0.5" }
  s.source_files = "**/*.{swift}"
  s.frameworks   = "UIKit"
  s.requires_arc = true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }
end

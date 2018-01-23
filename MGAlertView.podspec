Pod::Spec.new do |s|

  s.name         = "MGAlertView"
  s.version      = "1.0.0"
  s.summary      = "iOS 自定义弹框"

  s.homepage     = "https://github.com/xiaomage1478/MGAlertView"

  s.license      = "MIT"

  s.author       = { "小马哥" => "Martin1478@163.com" }

  s.platform     = :ios
  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/xiaomage1478/MGAlertView.git", :tag => "1.0.0"}

  s.source_files  = "MGAlertView/MGAlertView/Code/*.{h,m}"

  # s.public_header_files = "Classes/**/*.h"
  s.dependency  'Masonry'

  s.requires_arc = true


end
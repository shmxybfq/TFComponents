

Pod::Spec.new do |s|
s.name         = "TFComponents"
s.version      = "1.6.7"
s.ios.deployment_target = '9.0'
s.summary      = "A powerful tool for ztf"
s.homepage     = "https://github.com/shmxybfq/TFComponents"
s.license      = "MIT"
s.author             = { "ZTF" => "927141965@qq.com" }
s.social_media_url   = "https://github.com/shmxybfq/TFComponents"
s.source       = { :git => "https://github.com/shmxybfq/TFComponents.git", :tag => s.version }
s.source_files  = "TFComponents/**/*.{h,m}"
s.requires_arc = true
s.dependency "Masonry"
end

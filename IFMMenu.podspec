Pod::Spec.new do |s|
s.name        = 'IFMMenu'
s.version     = '1.0.3'
s.authors     = { 'liugangios' => 'ustbliugang@163.com' }
s.homepage    = 'https://github.com/liugangios/IFMMenu'
s.summary     = 'a dropdown menu for ios like wechat homepage.'
s.source      = { :git => 'https://github.com/liugangios/IFMMenu.git',
:tag => s.version.to_s }
s.license     = { :type => "MIT", :file => "LICENSE" }

s.platform = :ios, '7.0'
s.requires_arc = true
s.source_files = 'IFMMenu'
s.public_header_files = 'IFMMenu/*.h'

s.ios.deployment_target = '7.0'
end

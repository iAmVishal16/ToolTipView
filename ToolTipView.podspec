Pod::Spec.new do |s|
  s.name             = 'ToolTipView'
  s.version          = '1.0.0'
  s.summary          = 'A reusable toolTip component with animation and shadow in UIKit.'

  s.description      = <<-DESC
    ToolTipView is a reusable component that can be used to display a tooltip in UIKit with customizable text, shadow, and arrow. It includes animation and allows dismissal on tap.
  DESC

  s.homepage         = 'https://github.com/iAmVishal16/ToolTipView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Vishal Paliwal' => 'paliwalvishal16@gmail.com' }
  s.source           = { :git => 'https://github.com/iAmVishal16/ToolTipView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.0'
  s.source_files     = 'ToolTipView/*.{swift}'
end

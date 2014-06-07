Pod::Spec.new do |s|
  s.name             = "MWProportionalLayoutView"
  s.version          = "0.0.1"
  s.summary          = "A UIView subclass managing subviews with a layout algorithm determined by weights"
  s.description      = <<-DESC
                       A UIView subclass managing subviews. Size and position is calculated according to given weights.
                       DESC
  s.homepage         = "https://github.com/zliw/MWProportionalLayoutView"
  s.screenshots      =  "https://raw.githubusercontent.com/zliw/MWProportionalLayoutView/master/screenshots/screenshot.png"
  s.license          = 'MIT'
  s.author           = { "Martin Wilz" => "github@wilz.de" }
  s.source           = { :git => "https://github.com/zliw/MWProportionalLayoutView.git", :tag => "0.0.1" }

  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'Classes'
  s.public_header_files = 'Classes/*.h'
end

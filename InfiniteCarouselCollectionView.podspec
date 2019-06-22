#
# Be sure to run `pod lib lint InfiniteCarousel.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'InfiniteCarouselCollectionView'
  s.version          = '0.1.1'
  s.summary          = 'InfiniteCarousel is a lightweight lib, that provides implementation of horizontal infinite paginated carousel view.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
InfiniteCarousel is a lightweight lib, that provides implementation of horizontal infinite paginated carousel view. 
Just check out the class CarouselCollectionView.
                       DESC

  s.homepage         = 'https://github.com/filletofish/InfiniteCarousel'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'filletofish' => 'julik103@mail.ru' }
  s.source           = { :git => 'https://github.com/filletofish/InfiniteCarousel.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'InfiniteCarousel/Classes/**/*'
  
  # s.resource_bundles = {
  #   'InfiniteCarousel' => ['InfiniteCarousel/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

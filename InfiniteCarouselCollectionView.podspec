Pod::Spec.new do |s|
  s.name             = 'InfiniteCarouselCollectionView'
  s.version          = '0.1.3'
  s.summary          = 'InfiniteCarousel is a lightweight lib, that provides implementation of horizontal infinite paginated carousel view.'
  s.description      = <<-DESC
InfiniteCarousel is a lightweight lib, that provides implementation of horizontal infinite paginated carousel view. 
Just check out the class CarouselCollectionView.
                       DESC
  s.homepage         = 'https://github.com/filletofish/InfiniteCarousel'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'filletofish' => 'julik103@mail.ru' }
  s.source           = { :git => 'https://github.com/filletofish/InfiniteCarousel.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'Sources/InfiniteCarousel/**/*'
  s.swift_versions = [5.0]
end

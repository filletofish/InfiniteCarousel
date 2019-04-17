# InfiniteCarousel

[![CI Status](https://img.shields.io/travis/filletofish/InfiniteCarousel.svg?style=flat)](https://travis-ci.org/filletofish/InfiniteCarousel)
[![Version](https://img.shields.io/cocoapods/v/InfiniteCarousel.svg?style=flat)](https://cocoapods.org/pods/InfiniteCarousel)
[![License](https://img.shields.io/cocoapods/l/InfiniteCarousel.svg?style=flat)](https://cocoapods.org/pods/InfiniteCarousel)
[![Platform](https://img.shields.io/cocoapods/p/InfiniteCarousel.svg?style=flat)](https://cocoapods.org/pods/InfiniteCarousel)

![ezgif com-crop](https://user-images.githubusercontent.com/14925971/46984320-7c348780-d0dc-11e8-9f1c-6c459f011b46.gif)

InfiniteCarousel is a lightweight lib, that provides implementation of **horizontal infinite** collection view to display paginated items of equal-sized items
 
One should use `carouselDataSource` instead of `dataSource` and `delegate`.

For autoscrolling see `isAutoscrollEnabled`.

Underneath algorithm can be described as followed:
- Putting last at the index 0, and first item at the end: [4], [1], [2], [3], [4], [1]
- While scrolling, whenever user reaches the first or the last index – scroll without animation to respectively the same item, but not at the sides.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Prerequisites 
- Use equal-sized cells
- Use fullscreen width cells

## Installation

InfiniteCarousel is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'InfiniteCarouselCollectionView'
```

## Author

Filipp Fediakov, [Twitter](https://twitter.com/filippfediakov)

Special thanks to [@ilyailya](https://github.com/ilyailya)

## License

InfiniteCarousel is available under the MIT license. See the LICENSE file for more info.

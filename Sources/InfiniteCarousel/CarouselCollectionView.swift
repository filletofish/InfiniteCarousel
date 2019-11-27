//
//  CarouselCollectionView.swift
//  InfiniteCarousel
//
//  Created by Filipp Fediakov on 13.10.2018.
//

import UIKit

@objc public protocol CarouselCollectionViewDataSource {
  var numberOfItems: Int { get }
  func carouselCollectionView(_ carouselCollectionView: CarouselCollectionView,
                              cellForItemAt index: Int,
                              fakeIndexPath: IndexPath) -> UICollectionViewCell
  @objc optional func carouselCollectionView(_ carouselCollectionView: CarouselCollectionView,
                                             didSelectItemAt index: Int)
  @objc optional func carouselCollectionView(_ carouselCollectionView: CarouselCollectionView,
                                             didDisplayItemAt index: Int)
}

/// Horizontal **infinite** collection view to display paginated items of equal-sized items
///
/// One should use `carouselDataSource` instead of `dataSource` and `delegate`.
///
/// For autoscrolling see `isAutoscrollEnabled`.
///
/// Underneath algorithm can be described as followed:
/// - Putting last at the index 0, and first item at the end: [4], [1], [2], [3], [4], [1]
/// - While scrolling, whenever user reaches the first or the last index – scroll without animation to respectively the same item, but not at the sides.
///
public class CarouselCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
  public var carouselDataSource: CarouselCollectionViewDataSource?
  
  public var flowLayout: UICollectionViewFlowLayout
  
  public init(frame: CGRect, collectionViewFlowLayout layout: UICollectionViewFlowLayout) {
    flowLayout = layout
    super.init(frame: frame, collectionViewLayout: layout)
    self.delegate = self
    self.dataSource = self
    isPagingEnabled = true
    flowLayout.scrollDirection = .horizontal
    flowLayout.minimumLineSpacing = 0
    flowLayout.minimumInteritemSpacing = 0
  }
  
  required init?(coder aDecoder: NSCoder) {
    flowLayout = UICollectionViewFlowLayout()
    super.init(coder: aDecoder)
    self.collectionViewLayout = flowLayout
    self.delegate = self
    self.dataSource = self
    isPagingEnabled = true
    flowLayout.scrollDirection = .horizontal
    flowLayout.minimumLineSpacing = 0
    flowLayout.minimumInteritemSpacing = 0
  }
  
  
  private var numberOfItems: Int {
    return carouselDataSource?.numberOfItems ?? 0
  }
  
  private var fakeNumberOfItems: Int {
    if let realNumberOfItems = carouselDataSource?.numberOfItems,
      realNumberOfItems > 0 {
      return realNumberOfItems + 2
    } else {
      return 0
    }
  }
  
  private func getRealIndex(_ fakeIndexPath: IndexPath) -> Int {
    guard let realNumberOfItems = carouselDataSource?.numberOfItems else {
      return 0
    }
    
    if fakeIndexPath.row == realNumberOfItems + 1 {
      return 0
    }
    
    if fakeIndexPath.row == 0 {
      return realNumberOfItems - 1
    }
    
    return fakeIndexPath.row - 1
  }
  
  /// Sets current displayed page.
  /// Permissible values are from `0` to numberOfItems returned in `carouselDataSource`.
  public var currentPage: Int {
    get {
      let center = CGPoint(x: contentOffset.x + (frame.width / 2), y: (frame.height / 2))
      if let fakeIndexPath = indexPathForItem(at: center) {
        return getRealIndex(fakeIndexPath)
      } else {
        assertionFailure()
        return 0
      }
    }
    set {
      assert((0..<numberOfItems).contains(newValue))
      setFakePage(newValue + 1)
      notifyDatasourceOnDisplayPage(newValue)
    }
  }
  
  public var fakeCurrentPage: Int {
    get {
      return Int(ceil(contentOffset.x / flowLayout.itemSize.width))
    }
    set {
      setFakePage(newValue, animated: false)
    }
  }
  
  private func setFakePage(_ fakePage: Int, animated: Bool = false) {
    precondition((0..<fakeNumberOfItems).contains(fakePage))
    let newContentOffset = CGPoint(x: flowLayout.itemSize.width * CGFloat(fakePage), y: 0)
    setContentOffset(newContentOffset, animated: animated)
  }
  
  /// Sets current displayed page.
  /// Permissible values are from `0` to numberOfItems returned in `carouselDataSource`.
  public func setCurrentPage(_ page: Int, animated: Bool = false) {
    precondition((0..<numberOfItems).contains(page))
    setFakePage(page + 1, animated: animated)
  }
  
  private func loopItems(_ scrollView: UIScrollView) {
    let page = fakeCurrentPage
    if (page == 0) {
      setFakePage(fakeNumberOfItems - 2)
    } else if (page == fakeNumberOfItems) {
      setFakePage(1)
    }
  }
  
  // MARK: - UICollectionViewDelegate
  
  private func notifyDatasourceOnDisplayPage(_ index: Int) {
    carouselDataSource?.carouselCollectionView?(self, didDisplayItemAt: index)
  }
  
  
  public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    loopItems(scrollView)
    notifyDatasourceOnDisplayPage(currentPage)
  }
  
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    loopItems(scrollView)
    tryToStartTimer()
  }
  
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let realIndex = getRealIndex(indexPath)
    carouselDataSource?.carouselCollectionView?(self, didSelectItemAt: realIndex)
  }
  
  // MARK: - Autoscrolling
  
  private var autoscrollTimer: Timer?
  public var autoscrollTimeInterval: TimeInterval = 5.0
  
  public var isAutoscrollEnabled: Bool = false {
    didSet {
      if isAutoscrollEnabled {
        tryToStartTimer()
      } else {
        stopAutoscrollTimer()
      }
    }
  }
  
  
  private func tryToStartTimer() {
    guard isAutoscrollEnabled else {
      return
    }
    
    autoscrollTimer?.invalidate()
    autoscrollTimer = Timer.scheduledTimer(timeInterval: autoscrollTimeInterval, target: self, selector: #selector(scrollToNextElement), userInfo: nil, repeats: false)
  }
  
  private func stopAutoscrollTimer() {
    autoscrollTimer?.invalidate()
    autoscrollTimer = nil
  }
  
  @objc private func scrollToNextElement() {
    guard fakeNumberOfItems > 0 else { return }
    if fakeCurrentPage == fakeNumberOfItems - 1 {
      setFakePage(1)
      let newPageRealIndex = fakeCurrentPage < (numberOfItems) ? fakeCurrentPage : 0
      assert(newPageRealIndex == 1)
      setFakePage(fakeCurrentPage + 1, animated: true)
      tryToStartTimer()
      notifyDatasourceOnDisplayPage(newPageRealIndex)
      return
    } else {
      let newPageRealIndex = fakeCurrentPage < (numberOfItems) ? fakeCurrentPage : 0
      setFakePage(fakeCurrentPage + 1, animated: true)
      tryToStartTimer()
      notifyDatasourceOnDisplayPage(newPageRealIndex)
    }
  }
  
  // MARK: - UICollectionViewDataSource
  
  private var hasInitializedFirstPage = false
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if fakeNumberOfItems > 0 && !hasInitializedFirstPage {
      currentPage = 0
      hasInitializedFirstPage = true
    }
    return fakeNumberOfItems
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let carouselDataSource = carouselDataSource else {
      assertionFailure()
      return UICollectionViewCell()
    }
    
    let index = getRealIndex(indexPath)
    return carouselDataSource.carouselCollectionView(self, cellForItemAt: index, fakeIndexPath: indexPath)
  }
}


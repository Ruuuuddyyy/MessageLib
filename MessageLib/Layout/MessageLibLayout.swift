//
//  MessageLibLayout.swift
//  MessageLib
//
//  Created by Artem Vlasenko on 14.11.2019.
//  Copyright © 2019 Artem Vlasenko. All rights reserved.
//

import UIKit

protocol MessageLibLayoutDelegate: AnyObject {
    func collectionView( _ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
    func collectionView( _ collectionView: UICollectionView, heightForMesssageTextAtIndexPath indexPath: IndexPath) -> CGFloat
}

class MessageLibLayout: UICollectionViewLayout {
    
    weak var delegate: MessageLibLayoutDelegate?

    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 5

    private var cache: [UICollectionViewLayoutAttributes] = []

    private var contentHeight: CGFloat = 0

    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }    
    
    override func prepare() {
        guard cache.isEmpty, let collectionView = collectionView else {
          return
        }

        let columnWidth = contentWidth - 50
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
          
          //  let photoHeight = 0//= delegate?.collectionView( collectionView, heightForPhotoAtIndexPath: indexPath) ?? 180
            let height = cellPadding * 2 // + photoHeight
            let frame = CGRect(x: xOffset[column],
                               y: yOffset[column],
                               width: columnWidth,
                               height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
          
            // 5
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = CGRect(x: insetFrame.origin.x, y: insetFrame.origin.y, width: insetFrame.width, height: 100)
            
            cache.append(attributes)
          
            // 6
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
        
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
      
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
}

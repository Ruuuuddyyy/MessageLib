//
//  MessageLibLayout.swift
//  MessageLib
//
//  Created by Artem Vlasenko on 14.11.2019.
//  Copyright © 2019 Artem Vlasenko. All rights reserved.
//

import UIKit

protocol MessageLibLayoutDelegate: AnyObject {
   // func collectionView( _ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
    func collectionView( _ collectionView: UICollectionView, incomingOrOutgoingMessageAtIndexPath indexPath: IndexPath) -> MessageType
    func collectionView( _ collectionView: UICollectionView, heightForMesssageTextAtIndexPath indexPath: IndexPath) -> CGSize
}

class MessageLibLayout: UICollectionViewLayout {
    
    weak var delegate: MessageLibLayoutDelegate?
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

        var xOffset: [CGFloat] = []
        var yOffset: [CGFloat] = []
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
          
           // let cell = collectionView.cellForItem(at: indexPath)
            let sizeCell = delegate?.collectionView(collectionView, heightForMesssageTextAtIndexPath: indexPath)
        
            let xOffsetMessageType = (delegate?.collectionView(collectionView, incomingOrOutgoingMessageAtIndexPath: indexPath))! == .incoming ? 0 : contentWidth - sizeCell!.width
            
            if indexPath.row == 0 {
                yOffset.append(0)
            } else {
                yOffset.append(cache[indexPath.row - 1].frame.maxY)
            }
            xOffset.append(xOffsetMessageType)

          //  let photoHeight = 0//= delegate?.collectionView( collectionView, heightForPhotoAtIndexPath: indexPath) ?? 180
      //      let height = cellPadding * 2 // + photoHeight
            let frame = CGRect(x: xOffset[indexPath.row],
                               y: yOffset[indexPath.row],
                               width: sizeCell!.width,
                               height: sizeCell!.height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
          
            // 5
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = CGRect(x: insetFrame.origin.x, y: insetFrame.origin.y, width: insetFrame.width, height: insetFrame.height)
            
            cache.append(attributes)
            // 6
            contentHeight = max(contentHeight, frame.maxY)
          //  yOffset[indexPath.row] = yOffset[indexPath.row] + height
        }
    }
 
    func insertToCache(indexPath: IndexPath) {
        guard let collectionView = collectionView else { return }
        let sizeCell = delegate?.collectionView(collectionView, heightForMesssageTextAtIndexPath: indexPath)
          
        let xOffsetMessageType = (delegate?.collectionView(collectionView, incomingOrOutgoingMessageAtIndexPath: indexPath))! == .incoming ? 0 : contentWidth - sizeCell!.width

        let yOffset = cache.count == 0 ? 0 : (cache[indexPath.row - 1].frame.maxY)
        
        let frame = CGRect(x: xOffsetMessageType,
                           y: yOffset,
                           width: sizeCell!.width,
                           height: sizeCell!.height)
        let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
        
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = CGRect(x: insetFrame.origin.x, y: insetFrame.origin.y, width: insetFrame.width, height: insetFrame.height)
          
        cache.append(attributes)

        contentHeight = max(contentHeight, frame.maxY)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
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

//
//  CustomFlowLayout.swift
//  Interactive-Reorder
//
//  Created by Rohan Sanap on 22/07/21.
//

import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {
  override func layoutAttributesForInteractivelyMovingItem(at indexPath: IndexPath, withTargetPosition position: CGPoint) -> UICollectionViewLayoutAttributes {
    let movingAttributes = super.layoutAttributesForInteractivelyMovingItem(at: indexPath, withTargetPosition: position)
    movingAttributes.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    return movingAttributes
  }
}

//
//  ViewController.swift
//  Interactive-Reorder
//
//  Created by Rohan Sanap on 22/07/21.
//

import UIKit

class ViewController: UIViewController {

  lazy var collectionView: UICollectionView = {
    let layout = CustomFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return collectionView
  }()

  var colorsArray: [UIColor] = [
    .systemRed,
    .systemGreen,
    .systemBlue,
    .systemYellow,
    .systemTeal
  ]

  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    setupGesture()
  }

  private func setupCollectionView() {
    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: 80)
    ])

    collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)

    if let layout = collectionView.collectionViewLayout as? CustomFlowLayout {
      // layout.estimatedItemSize = CGSize(width: 60, height: 60)
      layout.itemSize = CGSize(width: 60, height: 60)
      layout.minimumLineSpacing = 10
      layout.scrollDirection = .horizontal
    }

    collectionView.dataSource = self
  }

  private func setupGesture() {
    let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
    collectionView.addGestureRecognizer(longPressGesture)
  }

  @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
    switch gesture.state {
    case .began:
      let location = gesture.location(in: collectionView)
      guard let indexPath = collectionView.indexPathForItem(at: location) else { return }
      collectionView.beginInteractiveMovementForItem(at: indexPath)
    case .changed:
      collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
    case .ended:
      collectionView.endInteractiveMovement()
    default:
      collectionView.cancelInteractiveMovement()
    }
  }
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.backgroundColor = colorsArray[indexPath.item]
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
    return true
  }

  func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let item = colorsArray.remove(at: sourceIndexPath.item)
    colorsArray.insert(item, at: destinationIndexPath.item)
  }
}

import UIKit

extension UICollectionView {
  
  func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
    let name = T.reuseID
    register(cellClass, forCellWithReuseIdentifier: name)
  }
  
  func dequeueReusableCell<T: UICollectionViewCell>(
    cellClass: T.Type,
    indexPath: IndexPath)
  -> T {
    let name = T.reuseID
    return dequeueReusableCell(withReuseIdentifier: name, for: indexPath) as! T
  }
  
}

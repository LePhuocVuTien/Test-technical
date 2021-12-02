import UIKit

extension UITableView {
  
  func register<T: UITableViewCell>(_ cellClass: T.Type) {
    let name = T.reuseID
    register(cellClass, forCellReuseIdentifier: name)
  }
  
  func dequeueReusableCell<T: UITableViewCell>(
    cellClass: T.Type,
    indexPath: IndexPath
  ) -> T {
    let name = T.reuseID
    return dequeueReusableCell(withIdentifier: name, for: indexPath) as! T
  }
  
}

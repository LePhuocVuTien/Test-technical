import UIKit
import Domain
import RxCocoa
import RxSwift
import RxDataSources

extension HomeController {
  
  func createDataSource() -> RxTableDataSource<SectionModel<String, Element>> {
    return RxTableDataSource<SectionModel<String, Element>>(
      configureCell: { (dataSource, tableView, indexPath, item) -> UITableViewCell in
        let cell = tableView.dequeueReusableCell(
          cellClass: Cell.self,
          indexPath: indexPath
        )
        cell.configure(item)
        return cell
      }
    )
  }
  
  func errorAlert(_ error: String) {
    DispatchQueue.main.async(execute: {
      let alertController = UIAlertController(
        title: Works.inform,
        message: error,
        preferredStyle: .alert
      )
      alertController.addAction(UIAlertAction(title: Works.ok, style: .default))
      self.present(alertController, animated: true, completion: nil)
      
    })
  }
}
  
extension Reactive where Base: HomeController {
  var fetching: Binder<Bool> {
    return Binder(self.base) { scene, item in
      _ = item
        ? scene.content.activity.startAnimating()
        : scene.content.activity.stopAnimating()
    }
  }
  
  var erorr: Binder<Error> {
    return Binder(self.base) { scene, item in
      scene.errorAlert(item.localizedDescription)
    }
  }
}

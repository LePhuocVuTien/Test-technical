import UIKit

protocol Navigator: class {
  var navigationController: NavigationController { get }
  func toScene()
}

extension Navigator {
  func toScene() {
  }
}

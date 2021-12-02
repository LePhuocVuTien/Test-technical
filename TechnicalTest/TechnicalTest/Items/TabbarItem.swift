import UIKit

enum TabBarItem: CaseIterable{
  case home
  case options
  
  var name: String {
    switch self {
      case .home:
        return "Home"
      case .options:
        return "Options"
    }
  }
  
  var icon: UIImage? {
    switch self {
      case .home:
        return UIImage(named: "home")
      case .options:
        return UIImage(named: "info")
    }
  }
}

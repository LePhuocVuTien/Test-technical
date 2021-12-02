import UIKit

enum DayItem: Int {
  case mon = 0
  case tue = 1
  case wed = 2
  case thu = 3
  case fri = 4
  case sat = 5
  case sun = 6
  
  var name: String {
    switch self {
      case .mon:
        return "Mon"
      case .tue:
        return "Tue"
      case .wed:
        return "Wed"
      case .thu:
        return "Thu"
      case .fri:
        return "Fri"
      case .sat:
        return "Sat"
      case .sun:
        return "Sun"
    }
  }
  
  var day: String {
    switch self {
      case .mon:
        return "20"
      case .tue:
        return "21"
      case .wed:
        return "22"
      case .thu:
        return "23"
      case .fri:
        return "24"
      case .sat:
        return "25"
      case .sun:
        return "26"
    }
  }
}

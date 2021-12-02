import UIKit

extension UIView {
  static var reuseID: String {
    return String(describing: self)
  }
  
  var safeAreaBottom : CGFloat {
    if #available(iOS 11, *) {
      return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
    }
    return 0
  }
  
  var safeAreaTop : CGFloat {
    if #available(iOS 11, *){
      return UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
    }
    return 0
  }
  
  func setHeight(_ h: CGFloat, animateTime: TimeInterval? = nil) {
    if let c = self.constraints
        .first(where: { $0.firstAttribute == .height && $0.relation == .equal }) {
      c.constant = CGFloat(h)
      if let animateTime = animateTime {
        UIView.animate(withDuration: animateTime, animations:{
          self.superview?.layoutIfNeeded()
        })
      }
      else {
        self.superview?.layoutIfNeeded()
      }
    }
  }
  
}

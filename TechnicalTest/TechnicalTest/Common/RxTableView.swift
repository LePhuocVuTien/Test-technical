import UIKit

public class RxTableView: UITableView {
  
  public override func layoutIfNeeded() {
    if window == nil {
      return
    }
    super.layoutIfNeeded()
  }
  
  public override func layoutSubviews() {
    if window == nil {
      return
    }
    super.layoutSubviews()
  }
  
}

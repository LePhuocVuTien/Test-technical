import UIKit

extension HomeController {
  
  class ContentView: UIView {
    
    lazy var tableView: UITableView = {
      let tableView = UITableView(frame: .zero)
      tableView.separatorStyle = .none
      tableView.showsVerticalScrollIndicator = false
      tableView.register(Cell.self)
      return tableView
    }()
    
    lazy var activity: UIActivityIndicatorView = {
      let spinner = UIActivityIndicatorView(style: .gray)
      spinner.backgroundColor = R.color.white()
      return spinner
    }()
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      setupViews()
      setConstraint()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
      addSubview(tableView)
      addSubview(activity)
    }
    
    private func setConstraint() {
      tableView.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
      
      activity.snp.makeConstraints {
        $0.center.equalToSuperview()
      }
    }
  }
}

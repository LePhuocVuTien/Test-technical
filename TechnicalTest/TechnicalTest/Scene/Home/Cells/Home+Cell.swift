import UIKit
import Domain
import RxDataSources
import RxCocoa
import RxSwift

extension HomeController {
  
  class Cell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    var item: HomeController.Element?
    var elements: [HomeViewModel.AssignmentElement] = []
    let assignmentTrigger = PublishRelay<[SectionModel<String, HomeViewModel.AssignmentElement>]>()
    
    private lazy var dataSource: RxTableDataSource<SectionModel<String, HomeViewModel.AssignmentElement>> = {
      return createDataSource()
    }()
    
    private lazy var content: UIView = {
      let view = UIView()
      view.layer.cornerRadius = 8.0
      return view
    }()
    
    private lazy var nameOfDay: UILabel = {
      let label = UILabel()
      label.font = R.font.openSansBold(size: 12)
      label.textColor = R.color.textSec()
      return label
    }()
    
    private lazy var day: UILabel = {
      let label = UILabel()
      label.font = R.font.openSansRegular(size: 16.0)
      label.textColor = R.color.textPri()
      return label
    }()
    
    private lazy var line: UIView = {
      let view = UIView()
      view.backgroundColor = R.color.line()
      return view
    }()
    
    lazy var tableView: UITableView = {
      let tableView = UITableView(frame: .zero)
      tableView.separatorStyle = .none
      tableView.showsVerticalScrollIndicator = false
      tableView.register(DetailCell.self)
      tableView.isScrollEnabled = false
      return tableView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      selectionStyle = .none
      setupViews()
      binding()
      setConstraints()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    private func binding() {
      tableView.rx.itemSelected
        .subscribe(onNext: { [weak self] indexPath in
          guard let self = self,
                self.elements.count > indexPath.row else {
            return
          }
          let status = self.elements[indexPath.row].item.status
          if status != 1 {
            self.elements[indexPath.row].item.status = status == 2 ? 0 : 2
            self.elements[indexPath.row].isActive = !self.elements[indexPath.row].isActive
          }
          self.assignmentTrigger.accept([SectionModel(model: "", items: self.elements)])
        }).disposed(by: disposeBag)
    }
    
    private func setupViews() {
      addSubview(content)
      content.addSubview(tableView)
      addSubview(nameOfDay)
      addSubview(day)
      addSubview(line)
    }
    
    private func setConstraints() {
      content.snp.makeConstraints {
        $0.top.equalToSuperview().inset(20.0)
        $0.bottom.equalToSuperview().inset(19.0)
        $0.left.equalToSuperview().inset(71.0)
        $0.right.equalToSuperview().inset(21.0)
        $0.height.equalTo(72.0)
      }
      
      tableView.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
      
      nameOfDay.snp.makeConstraints {
        $0.top.equalToSuperview().inset(33.0)
        $0.left.equalToSuperview().inset(19.0)
        $0.width.equalTo(36.0)
        $0.height.equalTo(20.0)
      }
      
      day.snp.makeConstraints {
        $0.top.equalTo(nameOfDay.snp.bottom)
        $0.left.equalTo(nameOfDay.snp.left)
        $0.width.equalTo(26.0)
        $0.height.equalTo(19.0)
      }
      
      line.snp.makeConstraints {
        $0.left.right.bottom.equalToSuperview()
        $0.height.equalTo(1.0)
      }
    }
    
    func configure(_ element: Element) {
      item = element
      tableView.dataSource = nil
      nameOfDay.rx.text.onNext(element.day.name.uppercased())
      day.rx.text.onNext(element.day.day)
      content.isHidden = (element.item?.assignments.count ?? 0) == 0
      setDayColor(element.day.rawValue)
      
      guard let assignments = element.item?.assignments,
            assignments.count > 0 else {
        return
      }
      
      self.content.snp.updateConstraints {
        $0.height.equalTo(assignments.count * 91 - 19)
      }
      
      let items = assignments
        .map { assignment -> HomeViewModel.AssignmentElement in
          let status = StateExercisesItem(rawValue: assignment.status)
          return HomeViewModel.AssignmentElement(isActive: status == .completed , item: assignment)
        }
      
      self.elements = items
      assignmentTrigger
        .bind(to: self.tableView.rx.items(dataSource: self.dataSource))
        .disposed(by: self.disposeBag)
      assignmentTrigger.accept([SectionModel(model: "", items: items)])
    }
    
    func createDataSource() -> RxTableDataSource<SectionModel<String, HomeViewModel.AssignmentElement>> {
      return RxTableDataSource<SectionModel<String, HomeViewModel.AssignmentElement>>(
        configureCell: { (dataSource, tableView, indexPath, item) -> UITableViewCell in
          let cell = tableView.dequeueReusableCell(
            cellClass: DetailCell.self,
            indexPath: indexPath
          )
          cell.configure(item)
          return cell
        }
      )
    }
    
    func setDayColor(_ toDay: Int) {
      let date = Date()
      let calenderDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
      if toDay == calenderDate.day {
        nameOfDay.rx.textColor.onNext(R.color.textFor())
        day.rx.textColor.onNext(R.color.textFor())
      }
    }
  }
}

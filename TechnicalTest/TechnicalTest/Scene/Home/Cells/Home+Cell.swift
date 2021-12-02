import UIKit
import Domain

extension HomeController {
  
  class Cell: UITableViewCell {
    
    private var offset: CGFloat = 0
    
    var subViews: [UIView] = []
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      selectionStyle = .none
      setupViews()
      setConstraints()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
      addSubview(content)
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
        $0.height.greaterThanOrEqualTo(72.0)
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
      nameOfDay.rx.text.onNext(element.day.name.uppercased())
      day.rx.text.onNext(element.day.day)
      content.isHidden = (element.item?.assignments.count ?? 0) == 0
      
      guard let assignments = element.item?.assignments,
            assignments.count > 0 else {
        return
      }
      adjustCell(assignments: assignments)
    }
    
    func adjustCell(assignments: [Assignment]) {
      subViews = []
      offset = 0.0
      content.subviews.forEach({ $0.removeFromSuperview() })
      assignments.forEach { assignment in
        self.addChildView(assignment)
      }
      
      subViews.forEach { [weak self] view in
        guard let self = self else {return}
        self.content.addSubview(view)
        view.snp.makeConstraints {
          $0.top.equalToSuperview().offset(self.offset)
          $0.left.right.equalToSuperview()
          $0.height.equalTo(72.0)
        }
        offset += 80.0
      }
      
      content.snp.updateConstraints {
        $0.height.greaterThanOrEqualTo(offset - 8)
      }
    }
    
    func addChildView(_ item: Assignment) {
      let view = SubView()
      let statusExercises = StateExercisesItem(rawValue: item.status)
      let textColorTitle = statusExercises == .completed ? R.color.white() : R.color.textPri()
      let textColorStatus = statusExercises == .completed ? R.color.white() : R.color.textSec()
      
      view.title.rx.text.onNext(item.title)
      view.status.rx.textColor.onNext(textColorStatus)
      view.title.rx.textColor.onNext(textColorTitle)
      view.isCheck.rx.isHidden.onNext(!(statusExercises == .completed))
      
      switch statusExercises {
        case .missing:
          let text = "\(Works.missing) • \(item.totalExercise) \(Works.exercises.lowercased())"
          view.status.mixColorText(fullText: text, changeText: Works.missing, color: R.color.textThi()!)
          view.content.backgroundColor = R.color.bgNormal()
          
        case .normal:
          view.status.rx.text.onNext("\(item.totalExercise) \(Works.exercises.lowercased())")
          view.content.backgroundColor = R.color.bgNormal()
          
        case .completed:
          view.status.rx.text.onNext(Works.completed)
          view.content.backgroundColor = R.color.bgActive()
          
        case .none:
          break
      }
      subViews.append(view)
    }
  }
}

import UIKit
import Domain

extension HomeController {
  
  class DetailCell: UITableViewCell {
    
    var element: HomeViewModel.AssignmentElement?
    
    lazy var content: UIView = {
      let view = UIView()
      view.layer.cornerRadius = 8.0
      return view
    }()
    
    lazy var title: UILabel = {
      let label = UILabel()
      label.font = R.font.openSansBold(size: 15.0)
      label.textColor = R.color.textPri()
      return label
    }()
    
    lazy var status: UILabel = {
      let label = UILabel()
      label.font = R.font.openSansRegular(size: 15.0)
      label.textColor = R.color.textSec()
      return label
    }()
    
    lazy var isCheck: UIButton = {
      let button = UIButton()
      button.layer.cornerRadius = 12.0
      button.setImage(R.image.icCompletedTraining(), for: .normal)
      button.isHidden = true
      return button
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
      content.addSubview(title)
      content.addSubview(status)
      content.addSubview(isCheck)
    }
    
    private func setConstraints() {
      content.snp.makeConstraints {
        $0.top.equalToSuperview()
        $0.bottom.equalToSuperview().inset(19.0)
        $0.left.equalToSuperview()
        $0.right.equalToSuperview()
        $0.height.equalTo(72.0)
      }
      
      title.snp.makeConstraints {
        $0.right.equalToSuperview().inset(60.0)
        $0.top.left.equalToSuperview().inset(16.0)
      }
      
      status.snp.makeConstraints {
        $0.top.equalTo(title.snp.bottom).offset(3.0)
        $0.left.right.equalToSuperview().inset(16.0)
      }
      
      isCheck.snp.makeConstraints {
        $0.right.equalToSuperview().inset(24.0)
        $0.centerY.equalToSuperview()
        $0.size.equalTo(24.0)
      }
    }
    
    func configure(_ element: HomeViewModel.AssignmentElement) {
      self.element = element
      let item = element.item
      let statusExercises = StateExercisesItem(rawValue: item.status)
      
      let textColorTitle = statusExercises == .completed ? R.color.white() : R.color.textPri()
      let textColorStatus = statusExercises == .completed ? R.color.white() : R.color.textSec()
      
      title.rx.text.onNext(item.title)
      status.rx.textColor.onNext(textColorStatus)
      title.rx.textColor.onNext(textColorTitle)
      isCheck.rx.isHidden.onNext(!element.isActive)
      
      switch statusExercises {
        case .missing:
          let text = "\(Works.missing) • \(item.totalExercise) \(Works.exercises.lowercased())"
          status.mixColorText(fullText: text, changeText: Works.missing, color: R.color.textThi()!)
          content.backgroundColor = R.color.bgNormal()
          
        case .normal:
          status.rx.text.onNext("\(item.totalExercise) \(Works.exercises.lowercased())")
          content.backgroundColor = R.color.bgNormal()
          
        case .completed:
          status.rx.text.onNext(Works.completed)
          content.backgroundColor = R.color.bgActive()
          
        case .none:
          break
      }
    }
  }
}

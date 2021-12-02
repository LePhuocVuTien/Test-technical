
import UIKit
import RxSwift

extension HomeController {

  class SubView: UIView {
    
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

    override init(frame: CGRect) {
      super.init(frame: frame)
      setupViews()
      setConstraint()
    }

    public required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }

    private func setupViews() {
      addSubview(content)
      content.addSubview(title)
      content.addSubview(status)
      content.addSubview(isCheck)
    }

    private func setConstraint() {
      content.snp.makeConstraints {
        $0.edges.equalToSuperview()
      }
      
      title.snp.makeConstraints {
        $0.right.equalToSuperview().inset(60.0)
        $0.top.left.right.equalToSuperview().inset(16.0)
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
  }
}

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import Domain
import RxDataSources

class HomeController: UIViewController, UIScrollViewDelegate {
  
  typealias Element = HomeViewModel.Element
  
  let disposeBag = DisposeBag()
  var viewModel: HomeViewModel!
  lazy var content = ContentView(frame: .zero)
  
  private lazy var dataSource: RxTableDataSource<SectionModel<String, Element>> = {
      return createDataSource()
    }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
  }
  
  override func loadView() {
    super.loadView()
    bindViewModel()
    setupViews()
    setConstaint()
  }
  
  private func bindViewModel() {
    let viewDidLoadTrigger = rx
      .sentMessage(#selector(Self.viewDidLoad))
      .mapToVoid()
      .asDriverOnErrorJustComplete()
    
    let input = HomeViewModel.Input(
      viewDidLoad: viewDidLoadTrigger
    )
    
    let output = viewModel.transform(input: input)
    
    output.calendar
      .drive(content.tableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
    
    output.fetching
      .drive(rx.fetching)
      .disposed(by: disposeBag)
    
    output.error
      .drive(rx.erorr)
      .disposed(by: disposeBag)
  }
  
  private func setConstaint() {
    content.snp.makeConstraints {
      $0.top.left.right.equalToSuperview()
      $0.height.equalTo(UIScreen.main.bounds.height)
    }
  }
  
  private func setupViews() {
    view.addSubview(content)
  }
}


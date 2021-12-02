import Domain
import RxSwift
import RxCocoa
import RxDataSources

final class HomeViewModel: ViewModelType {
  
  private let useCase: Domain.SearchUseCase
  private var elements: [Element] = []
  
  init(useCase: Domain.SearchUseCase) {
    self.useCase = useCase
  }
  
  struct Input {
    let viewDidLoad: Driver<Void>
    let itemSelected: Driver<Element>
  }
  
  struct Output {
    let calendar: Driver<[SectionModel<String, Element>]>
    let itemSelected: Driver<Element>
    let fetching: Driver<Bool>
    let error: Driver<Error>
  }
  
  func transform(input: Input) -> Output {
    
    let activityIndicator = ActivityIndicator()
    let errorTracker = ErrorTracker()
    
    let defaultItem = input.viewDidLoad
      .map {return [SectionModel(model: "", items: self.makeElements())]}
    
    let items = input.viewDidLoad
      .debounce(.microseconds(1000))
      .flatMapLatest { [weak self] _ -> Driver<[Domain.Item]> in
        guard let self = self else {return .empty()}
        return self.fetch()
          .trackError(errorTracker)
          .trackActivity(activityIndicator)
          .asDriverOnErrorJustComplete()
      }
      .do(onNext: { [weak self] items in
        self?.elements = self?.makeElements(items: items) ?? []
      })
      .map {return [SectionModel(model: "", items: self.makeElements(items: $0))]}
    
    let calendar = Driver.merge(defaultItem, items)
    
    let fetching = activityIndicator.asDriver()
    let error = errorTracker.asDriver()
    
    return Output(
      calendar: calendar,
      itemSelected: input.itemSelected,
      fetching: fetching,
      error: error
    )
  }
  
  func makeElements() -> [Element] {
    var elements: [Element] = []
    for i in 0..<7 {
      guard let day = DayItem(rawValue: i) else {continue}
      elements.append(Element(isActive: false, day: day , item: nil))
    }
    return elements
  }
  
  func makeElements(items: [Domain.Item]) -> [Element] {
    var elements: [Element] = []
    items.forEach { item in
      guard let day = DayItem(rawValue: item.day) else {return}
      elements.append(Element(isActive: false, day: day, item: item))
    }
    return elements
  }
  
  private func fetch() -> Observable<[Domain.Item]> {
    return self.useCase.fetch()
      .flatMapLatest { data -> Observable<[Domain.Item]> in
        guard data.data.count > 0 else {
          let error = NSError.makeError(message: Works.error)
          return Observable.error(error)
        }
        return Observable.of(data.data)
      }
  }
}

extension HomeViewModel {
  struct Element {
    var isActive: Bool
    var day: DayItem
    var item: Domain.Item?
  }
}

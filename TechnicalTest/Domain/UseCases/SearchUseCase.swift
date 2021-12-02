import RxSwift

public protocol SearchUseCase {
  func fetch() -> Observable<Domain.Data>
}


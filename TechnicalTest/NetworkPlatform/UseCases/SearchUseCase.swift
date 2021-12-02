import Domain
import RxSwift

final class SearchUseCase: Domain.SearchUseCase {
  private let network: DetailNetwork<Domain.Data>
  
  init(network: DetailNetwork<Domain.Data>) {
    self.network = network
  }
  
  func fetch() -> Observable<Domain.Data> {
    return network.fetch()
  }
}

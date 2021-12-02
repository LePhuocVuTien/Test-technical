import Domain
import RxSwift

public final class DetailNetwork<T: Decodable> {
  private let network: Network<T>
  
  init(network: Network<T>) {
    self.network = network
  }
  
  func fetch() -> Observable<T> {
    return network.getItem("workouts")
  }
}


import Domain

final class NetworkProvider {
  private let apiEndpoint: String
  
  public init() {
    apiEndpoint = "https://demo2187508.mockable.io"
  }
  
  public func makeSearchNetwork() -> DetailNetwork<Domain.Data> {
    let network = Network<Domain.Data>(apiEndpoint)
    return DetailNetwork(network: network)
  }
}

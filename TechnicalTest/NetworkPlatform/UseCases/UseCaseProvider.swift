import Foundation
import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {
  
  private let networkProvider: NetworkProvider
  
  public init() {
    networkProvider = NetworkProvider()
  }
  
  public func makeSearchUseCase() -> Domain.SearchUseCase {
    return SearchUseCase(network: networkProvider.makeSearchNetwork())
  }
}

import UIKit
import Domain
import NetworkPlatform

final class Application {
  
  static let shared = Application()
  private let useCaseProvider: Domain.UseCaseProvider
  
  private init() {
    self.useCaseProvider = NetworkPlatform.UseCaseProvider()
    UIFont.registerCustomFonts()
  }
  
  func configure(in window: UIWindow) {
    let viewModel = HomeViewModel(useCase: useCaseProvider.makeSearchUseCase())
    let controller = HomeController()
    controller.viewModel = viewModel
    window.rootViewController = controller
    window.makeKeyAndVisible()
  }
}

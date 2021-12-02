public protocol UseCaseProvider {
  func makeSearchUseCase() -> SearchUseCase
}

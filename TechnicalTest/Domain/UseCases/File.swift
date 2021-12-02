public protocol UseCaseProvider {
  func makeHomeUseCase() -> HomeUseCase
  func makeSavedUseCase() -> SavedUseCase
  func makeOptionsUseCase() -> OptionsUseCase
  func makeAddPlaceUseCase() -> AddPlaceUseCase
  func makeSearchUseCase() -> SearchUseCase
  func makeUserInfoUseCase() -> UserInfoUseCase
  func makePlaceDetailUseCase() -> PlaceDetailUseCase
  func makeBuildingUseCase() -> BuildingUseCase
  func makeDroppedPinUseCase() -> DroppedPinUseCase
  func makeCategoryUseCase() -> CategoryUseCase
  func makeBuildingSearchUseCase() -> BuildingSearchUseCase
}

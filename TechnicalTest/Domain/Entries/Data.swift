import Foundation

public struct Data: Codable {
  public var data: [Item]
  
  public init(data: [Item]){
    self.data = data
  }
  
  private enum CodingKeys: String, CodingKey {
    case data
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    data = (try? container.decode([Item].self, forKey: .data)) ?? []
  }
}

extension Data: Equatable {
  public static func == (lhs: Data, rhs: Data) -> Bool {
    return lhs.data == rhs.data
  }
}

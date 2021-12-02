import Foundation

public struct Item: Codable {
  public var id: String
  public var day: Int
  public var assignments: [Assignment]
  
  public init(id: String, day: Int, assignments: [Assignment]){
    self.id = id
    self.day = day
    self.assignments = assignments
  }
  
  private enum CodingKeys: String, CodingKey {
    case id = "_id"
    case day
    case assignments
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = (try? container.decode(String.self, forKey: .id)) ?? ""
    day = (try? container.decode(Int.self, forKey: .day)) ?? -1
    assignments = (try? container.decode([Assignment].self, forKey: .assignments)) ?? []
  }
}

extension Item: Equatable {
  public static func == (lhs: Item, rhs: Item) -> Bool {
    return lhs.id == rhs.id &&
      lhs.day == rhs.day &&
      lhs.assignments == rhs.assignments
  }
}

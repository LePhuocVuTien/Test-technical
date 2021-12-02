public struct Assignment: Codable {
  public var id: String
  public var title: String
  public var status: Int
  public var totalExercise: Int
  
  public init(
    id: String,
    title: String,
    status: Int,
    totalExercise: Int
  ){
    self.id = id
    self.title = title
    self.status = status
    self.totalExercise = totalExercise
  }
  
  private enum CodingKeys: String, CodingKey {
    case id = "_id"
    case title
    case status
    case totalExercise = "total_exercise"
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = (try? container.decode(String.self, forKey: .id)) ?? ""
    title = (try? container.decode(String.self, forKey: .title)) ?? ""
    status = (try? container.decode(Int.self, forKey: .status)) ?? 0
    totalExercise = (try? container.decode(Int.self, forKey: .totalExercise)) ?? 0
  }
}

extension Assignment: Equatable {
  public static func == (lhs: Assignment, rhs: Assignment) -> Bool {
    lhs.id == rhs.id &&
      lhs.title == rhs.title &&
      lhs.status == rhs.status &&
      lhs.totalExercise == rhs.totalExercise
  }
}

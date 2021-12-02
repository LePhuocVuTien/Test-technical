import UIKit

extension NSError {
  static func makeError(message: String) -> Error {
    let error = NSError(
      domain: "Domain",
      code: 0,
      userInfo: [NSLocalizedDescriptionKey: message]
    )
    return error
  }
}

import Foundation
import Alamofire
import Domain
import RxAlamofire
import RxSwift

final class Network<T: Decodable> {
  
  private let endPoint: String
  private let scheduler: ConcurrentDispatchQueueScheduler
  
  init(_ endPoint: String) {
    self.endPoint = endPoint
    let qos = DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1)
    self.scheduler = ConcurrentDispatchQueueScheduler(qos: qos)
  }
  
  func getItem(_ path: String) -> Observable<T> {
    let absolutePath = "\(endPoint)/\(path)"
    return RxAlamofire
      .data(.get, absolutePath)
      .observe(on: scheduler)
      .map({ data -> T in
        return try JSONDecoder().decode(T.self, from: data)
      })
  }
}

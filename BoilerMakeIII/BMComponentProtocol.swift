import Foundation

protocol BMComponentProtocol {
    var type: BMComponentType { get }
    var dictionary: NSDictionary { get }
    //var id: Int { get }
    //var state: Int { get set }
}

enum BMComponentType: String {
    case Label = "BMLabel"
    case Button = "BMButton"
    case ImageView = "BMImageView"
}

import Foundation

protocol BMComponentProtocol {
    var type: BMComponentType { get }
    var dictionary: NSDictionary { get }
    var id: Int { get }
    //var state: Int { get set }
    
    var isNew: Bool {get set}
}

enum BMComponentType: String {
    case Label = "BMLabel"
    case Button = "BMButton"
    case ImageView = "BMImageView"
    case ViewController = "BMViewController"
    case TableViewController = "BMTableViewController"
    case WebViewController = "BMWebViewController"
    case Application = "BMApplication"
}

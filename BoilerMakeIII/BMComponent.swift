import Foundation

protocol BMComponent {
    
    var type: BMComponentType { get }
    
    var dictionary: NSDictionary { get }
    
}


enum BMComponentType: String {
    
    case Label = "BMLabel"
    case Button = "BMButton"
    case ImageView = "BMImageView"
}

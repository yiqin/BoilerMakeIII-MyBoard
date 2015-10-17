import UIKit

enum BMButtonActionType {
    case pushNextView
}


class BMButton: UIButton, BMComponent {
    
    var type = BMComponentType.Button
    
    var dictionary: NSDictionary {
        let x: CGFloat = self.frame.origin.x / screenWidth
        let y: CGFloat = self.frame.origin.y / screenHeight
        let width: CGFloat = self.frame.width / screenWidth
        let height: CGFloat = self.frame.height / screenHeight
        
        let dict: NSMutableDictionary = NSMutableDictionary()
        
        dict.setObject(type.rawValue, forKey: "type")
        
        dict.setObject(x, forKey: "x")
        dict.setObject(y, forKey: "y")
        dict.setObject(width, forKey: "width")
        dict.setObject(height, forKey: "height")
        dict.setObject(self.titleForState(UIControlState.Normal)!, forKey: "title")
        return NSDictionary(dictionary: dict)
    }
    
    init(frame: CGRect, dict: NSDictionary) {
        super.init(frame: frame)
        
        self.setTitle(dict["title"] as? String, forState: UIControlState.Normal)
        self.setTitleColor(iosBlue, forState: .Normal)
        self.setTitleColor(iosSelectedBlue, forState: .Selected)
        self.setTitleColor(iosSelectedBlue, forState: .Highlighted)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

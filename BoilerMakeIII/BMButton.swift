import UIKit

enum BMButtonActionType {
    case pushNextView
}


class BMButton: UIButton, BMComponentProtocol {
    
    var type = BMComponentType.Button
    var id: Int;
    
    var dictionary: NSDictionary {
        let x: CGFloat = frame.origin.x / screenWidth
        let y: CGFloat = frame.origin.y / screenHeight
        let width: CGFloat = frame.width / screenWidth
        let height: CGFloat = frame.height / screenHeight
        
        let dict: NSMutableDictionary = NSMutableDictionary()
        
        dict.setObject(type.rawValue, forKey: "type")
        dict.setObject(id, forKey: "id")
        dict.setObject(x, forKey: "x")
        dict.setObject(y, forKey: "y")
        dict.setObject(width, forKey: "width")
        dict.setObject(height, forKey: "height")
        dict.setObject(self.titleForState(UIControlState.Normal)!, forKey: "title")
        return NSDictionary(dictionary: dict)
    }
    
    // Reconstruct init.
    init(frame: CGRect, dict: NSDictionary) {
        id = (dict["id"]?.integerValue)!
        super.init(frame: frame)
    
        setTitle(dict["title"] as? String, forState: UIControlState.Normal)
        initColor()
    }
    
    override init(frame: CGRect) {
        id = BMStoryboardDataManager.sharedInstance.getNextID()
        super.init(frame: frame)
        
        setTitle("Button", forState: UIControlState.Normal)
        initColor()
    }
    
    private func initColor() {
        setTitleColor(iosBlue, forState: .Normal)
        setTitleColor(iosSelectedBlue, forState: .Selected)
        setTitleColor(iosSelectedBlue, forState: .Highlighted)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

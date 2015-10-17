import UIKit

class BMLabel: UILabel, BMComponentProtocol{
    
    var type = BMComponentType.Label
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
        dict.setObject(font.fontName, forKey: "fontName")
        dict.setObject(font.pointSize, forKey: "fontSize")
        dict.setObject(self.text!, forKey: "text")
        return NSDictionary(dictionary: dict)
    }
    
    // Reconstruct init.
    init(frame: CGRect, dict: NSDictionary) {
        id = (dict["id"]?.integerValue)!
        super.init(frame: frame)
        
        text = dict["text"] as? String
        font = UIFont(name: dict["fontName"] as! String, size: dict["fontSize"] as! CGFloat)
        backgroundColor = UIColor.redColor()
    }
    
    override init(frame: CGRect) {
        id = BMStoryboardDataManager.sharedInstance.getNextID()
        super.init(frame: frame)
        backgroundColor = UIColor.redColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

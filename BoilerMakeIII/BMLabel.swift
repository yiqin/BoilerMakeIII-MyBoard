import UIKit

class BMLabel: UILabel, BMComponent{
    
    var type = BMComponentType.Label
    
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
        dict.setObject(font.fontName, forKey: "fontName")
        dict.setObject(font.pointSize, forKey: "fontSize")
        dict.setObject(self.text!, forKey: "text")
        return NSDictionary(dictionary: dict)
    }
    
    init(frame: CGRect, dict: NSDictionary) {
        super.init(frame: frame)
        
        self.text = dict["text"] as? String
        self.font = UIFont(name: dict["fontName"] as! String, size: dict["fontSize"] as! CGFloat)
        self.backgroundColor = UIColor.redColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

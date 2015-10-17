import UIKit

class BMLabel: UILabel, BMComponent{
    var bound: CGRect
    
    var type = BMComponentType.Label
    
    var dictionary: NSDictionary {
        let x: CGFloat = self.frame.origin.x / self.bound.width
        let y: CGFloat = self.frame.origin.y / self.bound.height
        let width: CGFloat = self.frame.width / self.bound.width
        let height: CGFloat = self.frame.height / self.bound.height
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
    
    init(bound: CGRect, frame: CGRect, dict: NSDictionary) {
        self.bound = bound
        super.init(frame: frame)
        
        self.text = dict["text"] as? String
        self.font = UIFont(name: dict["fontName"] as! String, size: dict["fontSize"] as! CGFloat)
        self.backgroundColor = UIColor.redColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import UIKit

class BMButton: UIButton, BMComponent {
    var bound: CGRect
    
    var identifier: String {
        return "BMButton";
    }
    
    var dictionary: NSDictionary {
        let x: CGFloat = self.frame.origin.x / self.bound.width
        let y: CGFloat = self.frame.origin.y / self.bound.height
        let width: CGFloat = self.frame.width / self.bound.width
        let height: CGFloat = self.frame.height / self.bound.height
        let dict: NSMutableDictionary = NSMutableDictionary()
        dict.setObject(identifier, forKey: "type")
        dict.setObject(x, forKey: "x")
        dict.setObject(y, forKey: "y")
        dict.setObject(width, forKey: "width")
        dict.setObject(height, forKey: "height")
        dict.setObject(self.titleForState(UIControlState.Normal)!, forKey: "title")
        return NSDictionary(dictionary: dict)
    }
    
    init(bound: CGRect, frame: CGRect, dict: NSDictionary) {
        self.bound = bound
        super.init(frame: frame)
        
        self.setTitle(dict["title"] as? String, forState: UIControlState.Normal)
        self.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

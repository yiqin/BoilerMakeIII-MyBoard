import UIKit

class BMLabel: UILabel, BMComponentProtocol{
    
    var state: State = .Play
    
    var type = BMComponentType.Label
    var id: Int;
    
    var dictionary: NSDictionary {
        var x: CGFloat = frame.origin.x / (screenWidth)
        var y: CGFloat = frame.origin.y / (screenHeight)
        var width: CGFloat = frame.width / (screenWidth)
        var height: CGFloat = frame.height / (screenHeight)
        
        var fontPointSize = font.pointSize
        
        if state == .Edit {
            x = x/scaleDownRatio
            y = y/scaleDownRatio
            width = width/scaleDownRatio
            height = height/scaleDownRatio
            fontPointSize = font.pointSize/scaleDownRatio
        }
        
        let dict: NSMutableDictionary = NSMutableDictionary()
        
        dict.setObject(type.rawValue, forKey: "type")
        dict.setObject(id, forKey: "id")
        dict.setObject(x, forKey: "x")
        dict.setObject(y, forKey: "y")
        dict.setObject(width, forKey: "width")
        dict.setObject(height, forKey: "height")
        dict.setObject(font.fontName, forKey: "fontName")
        dict.setObject(fontPointSize, forKey: "fontSize")
        dict.setObject(self.text!, forKey: "text")
        return NSDictionary(dictionary: dict)
    }
    
    // Reconstruct init.
    init(frame: CGRect, dict: NSDictionary) {
        id = (dict["id"]?.integerValue)!
        super.init(frame: frame)
        setStyle()
        text = dict["text"] as? String
        font = UIFont(name: dict["fontName"] as! String, size: dict["fontSize"] as! CGFloat)
    }
    
    override init(frame: CGRect) {
        id = BMStoryboardDataManager.sharedInstance.getNextID()
        super.init(frame: frame)
        setStyle()
    }
    
    func setStyle() {
        text = "Label"
        layer.borderColor = iosBlue.CGColor
        layer.borderWidth = 1
        //layer.cornerRadius = 4
        textColor = iosBlue
        textAlignment = NSTextAlignment.Center
    }
    
    func setState(newState:State) {
        state = newState
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

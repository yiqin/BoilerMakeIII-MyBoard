import UIKit

enum BMButtonActionType {
    case pushNextView
}


class BMButton: UIButton, BMComponentProtocol {
    
    var storyboardState: State = .Play
    
    var type = BMComponentType.Button
    var id: Int;
    
    var dictionary: NSDictionary {
        var x: CGFloat = frame.origin.x / (screenWidth)
        var y: CGFloat = frame.origin.y / (screenHeight)
        var width: CGFloat = frame.width / (screenWidth)
        var height: CGFloat = frame.height / (screenHeight)
        
        // var fontPointSize = font.pointSize
        
        if storyboardState == .Edit {
            x = x/scaleDownRatio
            y = y/scaleDownRatio
            width = width/scaleDownRatio
            height = height/scaleDownRatio
            // fontPointSize = font.pointSize/scaleDownRatio
        }
        
        if tag == 10000 {
            x = x/scaleDownRatio
            y = y/scaleDownRatio
            width = width/scaleDownRatio
            height = height/scaleDownRatio
        }
        
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
    
    func setStoryboardState(newState:State) {
        storyboardState = newState
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

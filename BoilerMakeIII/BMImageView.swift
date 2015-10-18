import UIKit

class BMImageView: UIImageView, BMComponentProtocol {
    
    var storyboardState: State = .Play
    
    var filename: String
    
    var type = BMComponentType.ImageView
    var id: Int
    
    var isNew = false
    
    var dictionary: NSDictionary {
        var x: CGFloat = frame.origin.x / (screenWidth)
        var y: CGFloat = frame.origin.y / (screenHeight)
        var width: CGFloat = frame.width / (screenWidth)
        var height: CGFloat = frame.height / (screenHeight)
        
        if storyboardState == .Edit {
            x = x/scaleDownRatio
            y = y/scaleDownRatio
            width = width/scaleDownRatio
            height = height/scaleDownRatio
        }
        
        if isNew {
            x = x/scaleDownRatio
            y = y/scaleDownRatio
            width = width/scaleDownRatio
            height = height/scaleDownRatio
            
            isNew = false
        }
        
        let dict: NSMutableDictionary = NSMutableDictionary()
        
        dict.setObject(type.rawValue, forKey: "type")
        dict.setObject(id, forKey: "id")
        dict.setObject(x, forKey: "x")
        dict.setObject(y, forKey: "y")
        dict.setObject(width, forKey: "width")
        dict.setObject(height, forKey: "height")
        dict.setObject(self.filename, forKey: "filename")
        return NSDictionary(dictionary: dict)
    }
    
    // Reconstruct init.
    init(frame: CGRect, dict: NSDictionary) {
        filename = dict["filename"] as! String
        id = (dict["id"]?.integerValue)!
        super.init(frame: frame)
        
        backgroundColor = UIColor.blueColor()
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent(filename)
        image = UIImage(contentsOfFile: path)
    }
    
    override init(frame: CGRect) {
        id = BMStoryboardDataManager.sharedInstance.getNextID()
        filename = ""
        super.init(frame: frame)
        backgroundColor = UIColor.blueColor()
    }
    
    func setStoryboardState(newState:State) {
        storyboardState = newState
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import UIKit

class BMImageView: UIImageView, BMComponentProtocol {

    var filename: String
    
    var type = BMComponentType.ImageView
    var id: Int
    
    var dictionary: NSDictionary {
        let x: CGFloat = self.frame.origin.x / screenWidth
        let y: CGFloat = self.frame.origin.y / screenHeight
        let width: CGFloat = self.frame.width / screenWidth
        let height: CGFloat = self.frame.height / screenHeight
        
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import UIKit

class BMImageView: UIImageView, BMComponent {

    var filename: String
    
    var type = BMComponentType.ImageView
    
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
        dict.setObject(self.filename, forKey: "filename")
        return NSDictionary(dictionary: dict)
    }
    
    init(frame: CGRect, dict: NSDictionary) {
        self.filename = dict["filename"] as! String
        super.init(frame: frame)
        
        backgroundColor = UIColor.blueColor()
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent(self.filename)
        self.image = UIImage(contentsOfFile: path)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

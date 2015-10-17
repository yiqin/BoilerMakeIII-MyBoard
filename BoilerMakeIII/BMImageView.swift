import UIKit

class BMImageView: UIImageView, BMComponent {
    var bound: CGRect
    var filename: String
    
    var type = BMComponentType.ImageView
    
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
        dict.setObject(self.filename, forKey: "filename")
        return NSDictionary(dictionary: dict)
    }
    
    init(bound: CGRect, frame: CGRect, dict: NSDictionary) {
        self.bound = bound
        self.filename = dict["filename"] as! String
        super.init(frame: frame)
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent(self.filename)
        self.image = UIImage(contentsOfFile: path)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

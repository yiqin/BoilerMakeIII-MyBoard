import UIKit

class TestSerializeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let leftMargin: CGFloat = 0.04
    let rightMargin: CGFloat = 0.04
    let topMargin: CGFloat = 0.044
    let bottomMargin: CGFloat = 0.022
    var currentImageView: UIImageView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("width: \(self.view.frame.width), height: \(self.view.frame.height)")
        
        let bound = self.view.frame
        
        saveData()
        
        // Do any additional setup after loading the view, typically from a nib.
        if let arr = loadData() {
            for var i = 0; i < arr.count; i++ {
                let dict = arr.objectAtIndex(i) as! NSDictionary
                let frame = rectFromDict(bound, dict: dict)
                
                switch dict["type"] as! NSString {
                case "BMLabel":
                    let label = BMLabel(frame: frame, dict: dict)
                    self.view.addSubview(label)
                    print(label.dictionary)
                    break
                case "BMButton":
                    let button = BMButton(frame: frame, dict: dict)
                    self.view.addSubview(button)
                    print(button.dictionary)
                    break;
                case "BMImageView":
                    let imageView = BMImageView(frame: frame, dict: dict)
                    
                    // Bind gesture recognizer.
                    imageView.userInteractionEnabled = true
                    let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "showGallery:")
                    tapRecognizer.numberOfTapsRequired = 1
                    imageView.addGestureRecognizer(tapRecognizer)
                    self.view.addSubview(imageView)
                    
                    self.view.addSubview(imageView)
                    break;
                default:
                    break
                }
            }
            
        } else {
            print("WARNING: Couldn't create dictionary from UIData.plist! Default values will be used!")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Helper Functions
    
    func rectFromDict(bound: CGRect, dict: NSDictionary) -> CGRect {
        let x: CGFloat = dict["x"] as! CGFloat * bound.width
        let y: CGFloat = dict["y"] as! CGFloat * bound.height
        let width: CGFloat = dict["width"] as! CGFloat * bound.width
        let height: CGFloat = dict["height"] as! CGFloat * bound.height
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    // MARK: Image Picker
    func showGallery(sender: UIGestureRecognizer) {
        currentImageView = sender.view as? UIImageView
        
        let picker: UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .PhotoLibrary
        
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let chosenImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            let pngData: NSData = UIImagePNGRepresentation(chosenImage)!
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
            let imageFilename = "\(dateFormatter.stringFromDate(NSDate())).png"
            
            // Update filename and image.
            let imageView: BMImageView = currentImageView as! BMImageView
            imageView.image = UIImage(data: pngData)
            imageView.filename = imageFilename
            
            // Write image data to file.
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
            let documentsDirectory = paths.objectAtIndex(0) as! NSString
            let path = documentsDirectory.stringByAppendingPathComponent(imageFilename)
            print("Svae image: \(path)")
            pngData.writeToFile(path, atomically: false)
        }
        
        picker .dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Data Load/Save
    
    func loadData() -> NSArray? {
        // getting path to UIData.plist
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("UIData.plist")
        print(path)
        let resultArray = NSArray(contentsOfFile: path)
        print("Loaded UIData.plist file is --> \(resultArray)")
        let myArr = NSArray(contentsOfFile: path)
        return myArr
    }
    
    func saveData() {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("UIData.plist")
        print(path)
        let arr: NSMutableArray = []
        
        let label1Dict: NSDictionary =
            ["type": "BMLabel",
                "x": leftMargin,
                "y": topMargin,
                "width": 0.2,
                "height": 0.1,
                "text": "Label1",
                "fontName": "Futura-CondensedMedium",
                "fontSize": 15,
            ]
        arr.addObject(label1Dict)
        
        let label2Dict: NSDictionary =
            ["type": "BMLabel",
                "x": 1 - rightMargin - 0.2,
                "y": topMargin,
                "width": 0.2,
                "height": 0.1,
                "text": "Label2",
                "fontName": "Futura-Medium",
                "fontSize": 12
            ]
        arr.addObject(label2Dict)

        let button1Dict: NSDictionary =
            ["type": "BMButton",
                "x": 0.5 - 0.1 - leftMargin ,
                "y": 1 - bottomMargin - 0.1,
                "width": 0.2,
                "height": 0.1,
                "title": "Click me!",
            ]
        arr.addObject(button1Dict)
        
        let image1Dict: NSDictionary =
            ["type": "BMImageView",
                "x": leftMargin ,
                "y": 0.2 + topMargin,
                "width": 1 - leftMargin - rightMargin,
                "height": 0.3,
                "filename": "background.png",
            ]
        arr.addObject(image1Dict)
        
        //writing to UIData.plist
        arr.writeToFile(path, atomically: false)
        let resultArray = NSArray(contentsOfFile: path)
        print("Saved UIData.plist file is --> \(resultArray)")
    }
}


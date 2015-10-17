//
//  BMTemplateViewController.swift
//  BoilerMakeIII
//
//  Created by Yi Qin on 10/17/15.
//  Copyright © 2015 Yi Qin. All rights reserved.
//

import UIKit

class BMTemplateViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        saveData()
        
        // Do any additional setup after loading the view, typically from a nib.
        if let arr = loadData() {
            for var i = 0; i < arr.count; i++ {
                let dict = arr.objectAtIndex(i) as! NSDictionary
                let frame = rectFromDict(dict)
                
                switch dict["type"] as! NSString {
                case BMComponentType.Label.rawValue:
                    let label = BMLabel(frame: frame, dict: dict)
                    self.view.addSubview(label)
                    print(label.dictionary)
                    break
                case BMComponentType.Button.rawValue:
                    let button = BMButton(frame: frame, dict: dict)
                    self.view.addSubview(button)
                    print(button.dictionary)
                    break;
                case BMComponentType.ImageView.rawValue:
                    let imageView = BMImageView(frame: frame, dict: dict)
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
    
    func rectFromDict(dict: NSDictionary) -> CGRect {
        let x: CGFloat = dict["x"] as! CGFloat * screenWidth
        let y: CGFloat = dict["y"] as! CGFloat * screenHeight
        let width: CGFloat = dict["width"] as! CGFloat * screenWidth
        let height: CGFloat = dict["height"] as! CGFloat * screenHeight
        return CGRect(x: x, y: y, width: width, height: height)
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
            "x": 0,
            "y": 0 + 64.0/screenHeight,
            "width": 100.0/screenWidth,
            "height": 30.0/screenHeight,
            "text": "Label1",
            "fontName": "Futura-CondensedMedium",
            "fontSize": 15,
        ]
        arr.addObject(label1Dict)
        
        let label2Dict: NSDictionary =
        ["type": "BMLabel",
            "x": 150/screenWidth,
            "y": 0 + 64.0/screenHeight,
            "width": 100.0/screenWidth,
            "height": 30.0/screenHeight,
            "text": "Label2",
            "fontName": "Futura-Medium",
            "fontSize": 12
        ]
        arr.addObject(label2Dict)
        
        let button1Dict: NSDictionary =
        ["type": "BMButton",
            "x": 100/screenWidth,
            "y": 30.0/screenHeight + 64.0/screenHeight,
            "width": 100.0/screenWidth,
            "height": 30.0/screenHeight,
            "title": "Click me!",
        ]
        arr.addObject(button1Dict)
        
        let image1Dict: NSDictionary =
        ["type": "BMImageView",
            "x": 100/screenWidth,
            "y": 100/screenHeight + 64.0/screenHeight,
            "width": 50/screenWidth,
            "height": 50/screenHeight,
            "filename": "background.png",
        ]
        arr.addObject(image1Dict)
        
        //writing to UIData.plist
        arr.writeToFile(path, atomically: false)
        let resultArray = NSArray(contentsOfFile: path)
        print("Saved UIData.plist file is --> \(resultArray)")
    }
    

}

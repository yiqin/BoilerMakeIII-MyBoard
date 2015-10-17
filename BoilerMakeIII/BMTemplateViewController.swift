//
//  BMTemplateViewController.swift
//  BoilerMakeIII
//
//  Created by Yi Qin on 10/17/15.
//  Copyright © 2015 Yi Qin. All rights reserved.
//

import UIKit

class BMTemplateViewController: UIViewController {
    
    let leftMargin: CGFloat = 0.04
    let rightMargin: CGFloat = 0.04
    let topMargin: CGFloat = 0.044
    let bottomMargin: CGFloat = 0.022
    
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
                case BMComponentType.Label.rawValue:
                    let label = BMLabel(bound: bound, frame: frame, dict: dict)
                    self.view.addSubview(label)
                    print(label.dictionary)
                    break
                case BMComponentType.Button.rawValue:
                    let button = BMButton(bound: bound, frame: frame, dict: dict)
                    self.view.addSubview(button)
                    print(button.dictionary)
                    break;
                case BMComponentType.ImageView.rawValue:
                    let imageView = BMImageView(bound: bound, frame: frame, dict: dict)
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
            "height": 0.2,
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
            "height": 0.2,
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

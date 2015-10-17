//
//  BMStoryboardDataManager.swift
//  BoilerMakeIII
//
//  Created by Yi Qin on 10/17/15.
//  Copyright © 2015 Yi Qin. All rights reserved.
//

import Foundation
import UIKit

enum NavigationControllerType {
    case NavigationController
    case TabBarController
}

class BMStoryboardDataManager: NSObject {
    
    var viewControllers = [BMViewControllerProtocol]()
    
    static let sharedInstance = BMStoryboardDataManager()
    
    func saveData() {
        //
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("UIData.plist")
        print(path)
        
        // Another bug ???
        var dataDictionary = [String: AnyObject]()
        
        var viewControllerData: Dictionary = [String: AnyObject]()
        
        viewControllerData["UIData"] = saveUIData()
        viewControllerData["title"] = "view controller 1"
        
        dataDictionary["viewController1"] = viewControllerData
        
        
        var viewControllerData1: Dictionary = [String: AnyObject]()
        viewControllerData1["UIData"] = saveUIData2()
        viewControllerData1["title"] = "2"
        dataDictionary["viewController2"] = viewControllerData1
        
        
        // FIXME:
        // I don't know how to add to UIData.plist
        let arr: NSMutableArray = []
        
        
        saveUIData()
        
        
        //writing to UIData.plist
        arr.writeToFile(path, atomically: false)
        let resultArray = NSArray(contentsOfFile: path)
        print("Saved UIData.plist file is --> \(resultArray)")
    }
    
    func saveUIData() -> NSArray {
        
        let arr: NSMutableArray = []
        
        let label1Dict: NSDictionary =
        ["type": BMComponentType.Label.rawValue,
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
        ["type": BMComponentType.Label.rawValue,
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
        ["type": BMComponentType.Button.rawValue,
            "x": 100/screenWidth,
            "y": 30.0/screenHeight + 64.0/screenHeight,
            "width": 100.0/screenWidth,
            "height": 30.0/screenHeight,
            "title": "Click me!",
        ]
        arr.addObject(button1Dict)
        
        let image1Dict: NSDictionary =
        ["type": BMComponentType.ImageView.rawValue,
            "x": 100/screenWidth,
            "y": 100/screenHeight + 64.0/screenHeight,
            "width": 50/screenWidth,
            "height": 50/screenHeight,
            "filename": "background.png",
        ]
        arr.addObject(image1Dict)
        
        return arr as NSArray
    }

    func saveUIData2() -> NSArray {
        
        let arr: NSMutableArray = []
        
        let label1Dict: NSDictionary =
        ["type": BMComponentType.Label.rawValue,
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
        ["type": BMComponentType.Label.rawValue,
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
        ["type": BMComponentType.Button.rawValue,
            "x": 100/screenWidth,
            "y": 30.0/screenHeight + 64.0/screenHeight,
            "width": 100.0/screenWidth,
            "height": 30.0/screenHeight,
            "title": "Click me!",
        ]
        arr.addObject(button1Dict)
        
        let image1Dict: NSDictionary =
        ["type": BMComponentType.ImageView.rawValue,
            "x": 100/screenWidth,
            "y": 100/screenHeight + 64.0/screenHeight,
            "width": 50/screenWidth,
            "height": 50/screenHeight,
            "filename": "background.png",
        ]
        arr.addObject(image1Dict)
        
        return arr as NSArray
    }

    
    func testData() -> UIViewController {
        
        let navigationController = UINavigationController(nibName: nil, bundle: nil)
        
        let firstVC = BMTemplateViewController(nibName: nil, bundle: nil)
        firstVC.title = "Hello world"
        
        
        
        
        navigationController.viewControllers = [firstVC]
        return navigationController
    }
    
}

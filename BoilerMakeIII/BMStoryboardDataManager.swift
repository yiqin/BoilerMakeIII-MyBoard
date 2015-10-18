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
    
    var data: NSMutableDictionary = NSMutableDictionary()
 
    var applications: NSMutableArray = NSMutableArray()
    
    static let sharedInstance = BMStoryboardDataManager()
    
    var currentID: Int = 0
    
    override init() {
        super.init()
        self.loadData()
        self.updateID()
    }
    
    func updateID() {
        for (appId, appDict) in self.data {
            currentID = max(currentID, appId.integerValue)
            let vcDict: NSDictionary = appDict.objectForKey("viewControllers") as! NSDictionary
            for (vcID, viewControllers) in vcDict {
                currentID = max(currentID, vcID.integerValue)
                let compDict: NSDictionary = viewControllers.objectForKey("UIData") as! NSDictionary
                for (compID, _) in compDict {
                    currentID = max(currentID, compID.integerValue)
                }
            }
        }
        currentID++;
    }
    
    func getNextID() -> Int{
        return currentID++;
    }
    
    func loadData() {
        
        // getting path to UIData.plist
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("UIData.plist")
        print(path)
        let resultArray = NSDictionary(contentsOfFile: path)
        print("Loaded UIData.plist file is --> \(resultArray)")
        
        if let dict = NSDictionary(contentsOfFile: path) as? NSMutableDictionary {
            self.data = dict
            print(data)
            
            for (_, value) in self.data {
                let appDict: NSDictionary = value as! NSDictionary
                applications.addObject(BMApplication(dict: appDict))
            }
            
        } else {
            print("Cannot load UIData.plist")
        }
    }
    
    func saveData() {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("UIData.plist")
        print(path)
        
        let viewControllerData: NSDictionary =
            ["UIData": saveUIData(),
                "title": "view controller 1",
                "id": 8,
                "type": BMViewControllerType.ViewController.rawValue,
            ]
        
        let viewControllerData1: NSDictionary =
            ["UIData": saveUIData2(),
                "title": "view controller 2",
                "id": 9,
                "type": BMViewControllerType.ViewController.rawValue,
            ]
        
        let appData: NSDictionary =
            ["id": 10,
                "viewControllers":
                    ["8": viewControllerData,
                        "9": viewControllerData1,
                    ],
                "title": "I Love Design"
            ]
        
        let dict: NSDictionary = ["10": appData]
        
        //writing to UIData.plist
        dict.writeToFile(path, atomically: false)
        let resultArray = NSArray(contentsOfFile: path)
        print("Saved UIData.plist file is --> \(resultArray)")
    }
    
    // MARK: Fake Data goes here.
    
    func saveUIData() -> NSDictionary {
        
        let label1Dict: NSDictionary =
        ["type": BMComponentType.Label.rawValue,
            "id": 0,
            "x": 0,
            "y": 0 + 64.0/screenHeight,
            "width": 100.0/screenWidth,
            "height": 30.0/screenHeight,
            "text": "Label1",
            "fontName": "Futura-CondensedMedium",
            "fontSize": 15,
        ]
        
        let label2Dict: NSDictionary =
        ["type": BMComponentType.Label.rawValue,
            "id": 1,
            "x": 150/screenWidth,
            "y": 0 + 64.0/screenHeight,
            "width": 100.0/screenWidth,
            "height": 30.0/screenHeight,
            "text": "Label2",
            "fontName": "Futura-Medium",
            "fontSize": 12
        ]
        
        let button1Dict: NSDictionary =
        ["type": BMComponentType.Button.rawValue,
            "id": 2,
            "x": 100/screenWidth,
            "y": 30.0/screenHeight + 64.0/screenHeight,
            "width": 100.0/screenWidth,
            "height": 30.0/screenHeight,
            "title": "Click me!",
        ]
        
        let image1Dict: NSDictionary =
        ["type": BMComponentType.ImageView.rawValue,
            "id": 3,
            "x": 100/screenWidth,
            "y": 100/screenHeight + 64.0/screenHeight,
            "width": 50/screenWidth,
            "height": 50/screenHeight,
            "filename": "background.png",
        ]
        
        let dict: NSDictionary =
            ["0": label1Dict,
                "1": label2Dict,
                "2": button1Dict,
                "3": image1Dict,
            ]
        
        return dict
    }

    func saveUIData2() -> NSDictionary {
        
        let label1Dict: NSDictionary =
        ["type": BMComponentType.Label.rawValue,
            "id": 4,
            "x": 0,
            "y": 0 + 64.0/screenHeight,
            "width": 100.0/screenWidth,
            "height": 30.0/screenHeight,
            "text": "Label1",
            "fontName": "Futura-CondensedMedium",
            "fontSize": 15,
        ]
        
        let label2Dict: NSDictionary =
        ["type": BMComponentType.Label.rawValue,
            "id": 5,
            "x": 150/screenWidth,
            "y": 0 + 64.0/screenHeight,
            "width": 100.0/screenWidth,
            "height": 30.0/screenHeight,
            "text": "Label2",
            "fontName": "Futura-Medium",
            "fontSize": 12
        ]
        
        let button1Dict: NSDictionary =
        ["type": BMComponentType.Button.rawValue,
            "id": 6,
            "x": 100/screenWidth,
            "y": 30.0/screenHeight + 64.0/screenHeight,
            "width": 100.0/screenWidth,
            "height": 30.0/screenHeight,
            "title": "Click me!",
        ]
        
        let image1Dict: NSDictionary =
        ["type": BMComponentType.ImageView.rawValue,
            "id": 7,
            "x": 100/screenWidth,
            "y": 100/screenHeight + 64.0/screenHeight,
            "width": 50/screenWidth,
            "height": 50/screenHeight,
            "filename": "background.png",
        ]
        
        let dict: NSDictionary =
        ["4": label1Dict,
            "5": label2Dict,
            "6": button1Dict,
            "7": image1Dict,
        ]
        
        return dict
    }
    
    
    func getComponentsData(appID: Int, vcID: Int) -> NSDictionary? {
        if let appDict: NSDictionary = data.objectForKey(String(appID)) as? NSDictionary {
            if let vcDict: NSDictionary = (appDict.objectForKey("viewControllers") as! NSDictionary).objectForKey(String(vcID)) as? NSDictionary {
                return vcDict.objectForKey("UIData") as? NSDictionary
            }
        }
        return nil
    }
    
    func testData() -> UIViewController {
        
        let navigationController = UINavigationController(nibName: nil, bundle: nil)
        
        let app = BMStoryboardDataManager.sharedInstance.applications.objectAtIndex(0) as! BMApplication
        
        var vc = app.viewControllers.objectAtIndex(0) as! BMTemplateViewController
        
        navigationController.viewControllers = [vc]
        return navigationController
    }
    
}

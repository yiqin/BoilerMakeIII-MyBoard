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
        self.applications = NSMutableArray()
        
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
            
            saveFakeData()
            
        }
    }
    
    func saveFakeData() {
        
        self.applications.addObject(FakeData.app1())
        
        saveData()
        loadData()
        
    }
    
    func saveData() {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("UIData.plist")
        print(path)
        
        
        let dict: NSMutableDictionary = NSMutableDictionary()
        
        for app in self.applications {
            let application = app as! BMApplication
            dict.setObject(application.dictionary, forKey: String(application.id))
            print("***************************")
            print(application.dictionary)
            print("***************************")
        }
        
        //writing to UIData.plist
        dict.writeToFile(path, atomically: false)
        let result = NSDictionary(contentsOfFile: path)
        print("Saved UIData.plist file is --> \(result)")
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
        
        let vc = app.viewControllers.objectAtIndex(0) as! BMTemplateViewController
        
        navigationController.viewControllers = [vc]
        return navigationController
    }
    
}

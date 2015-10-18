//
//  BMApplication.swift
//  BoilerMakeIII
//
//  Created by Chen Xu on 10/17/15.
//  Copyright © 2015 Yi Qin. All rights reserved.
//

import Foundation

class BMApplication: NSObject, BMComponentProtocol {
    let viewControllers: NSMutableArray = NSMutableArray()
    var title: NSString
    var id: Int
    var type: BMComponentType = .Application
    
    var isNew = false
    
    var dictionary: NSDictionary {
        let dict: NSMutableDictionary = NSMutableDictionary()
        for case let viewController as BMComponentProtocol in self.viewControllers {
            let vcDict: NSDictionary = viewController.dictionary
            dict.setObject(vcDict, forKey: String(vcDict.objectForKey("id")!))
        }
        let appDict: NSMutableDictionary = NSMutableDictionary()
        appDict.setObject(dict, forKey: "viewControllers")
        appDict.setObject(id, forKey: "id")
        appDict.setObject(title, forKey: "title")
        appDict.setObject(self.type.rawValue, forKey: "type")
        return NSDictionary(dictionary: appDict)
    }
    
    init(dict: NSDictionary) {
        self.title = dict["title"] as! NSString
        self.id = (dict["id"]?.integerValue)!
        super.init()
        
        if let vcDict = dict["viewControllers"] as? NSDictionary {
            for (vcID, singleVCDict) in vcDict {
                let dictionary: NSDictionary = singleVCDict as! NSDictionary
                viewControllers.addObject(BMTemplateViewController(appID: self.id, vcID: vcID.integerValue!, dictionary: dictionary))
            }
        }
        
    }
}

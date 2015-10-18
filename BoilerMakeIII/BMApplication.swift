//
//  BMApplication.swift
//  BoilerMakeIII
//
//  Created by Chen Xu on 10/17/15.
//  Copyright © 2015 Yi Qin. All rights reserved.
//

import Foundation

class BMApplication: NSObject {
    let viewControllers: NSMutableArray = NSMutableArray()
    var title: NSString
    var id: Int
    
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

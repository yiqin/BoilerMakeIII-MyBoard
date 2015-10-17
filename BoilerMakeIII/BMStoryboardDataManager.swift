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
    
    func testData() -> UIViewController {
        
        let navigationController = UINavigationController(nibName: nil, bundle: nil)
        
        let firstVC = BMTemplateViewController(nibName: nil, bundle: nil)
        firstVC.title = "Hello world"
        
        
        
        
        navigationController.viewControllers = [firstVC]
        return navigationController
    }
    
}

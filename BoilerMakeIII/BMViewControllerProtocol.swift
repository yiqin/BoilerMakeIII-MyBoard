//
//  BMViewControllerProtocol.swift
//  BoilerMakeIII
//
//  Created by Yi Qin on 10/17/15.
//  Copyright © 2015 Yi Qin. All rights reserved.
//

import Foundation

protocol BMViewControllerProtocol {
    
    var identifier: String { get }
    
}


enum BMViewControllerType {
    case ViewController
    case TableViewController
    case WebViewController
}

//
//  FakeData.swift
//  BoilerMakeIII
//
//  Created by Yi Qin on 10/17/15.
//  Copyright © 2015 Yi Qin. All rights reserved.
//

import Foundation

class FakeData {
    class func app1() -> BMApplication {
        
        // View Controller 1...
        
        func saveUIData() -> NSDictionary {
            
            let label1Dict: NSDictionary =
            ["type": BMComponentType.Label.rawValue,
                "id": 0,
                "x": xPadding/screenWidth,
                "y": (yPadding+64)/screenHeight,
                "width": (screenWidth-2*xPadding)/screenWidth,
                "height": 44.0/screenHeight,
                "text": "Label1 - hello world......",
                "fontName": "Lato-Semibold",
                "fontSize": 15,
            ]
            
            let button1Dict: NSDictionary =
            ["type": BMComponentType.Button.rawValue,
                "id": 2,
                "x": xPadding/screenWidth,
                "y": (screenHeight-64.0)/screenHeight,
                "width": (screenWidth-2*xPadding)/screenWidth,
                "height": 44.0/screenHeight,
                "title": "Click me!",
            ]
            
            let image1Dict: NSDictionary =
            ["type": BMComponentType.ImageView.rawValue,
                "id": 3,
                "x": xPadding/screenWidth,
                "y": (yPadding*2+64+44.0)/screenHeight,
                "width": (screenWidth-2*xPadding)/screenWidth,
                "height": (screenHeight-(yPadding*2+64)-64.0-64.0)/screenHeight,
                "filename": "background.png",
            ]
            
            let dict: NSDictionary =
            ["0": label1Dict,
                "1": button1Dict,
                "2": image1Dict,
            ]
            
            return dict
        }
        
        // View Controller 2...
        
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

        
        let viewControllerData1: NSDictionary =
        ["UIData": saveUIData(),
            "title": "view controller 1",
            "id": 8,
            "type": BMViewControllerType.ViewController.rawValue,
        ]
        
        let viewControllerData2: NSDictionary =
        ["UIData": saveUIData2(),
            "title": "view controller 2",
            "id": 9,
            "type": BMViewControllerType.ViewController.rawValue,
        ]
        
        let appData1: NSDictionary =
        ["id": 10,
            "viewControllers":
                ["8": viewControllerData1,
                    "9": viewControllerData2,
            ],
            "title": "I Love Design"
        ]
        
        return BMApplication(dict: appData1)
        
    }
    
}
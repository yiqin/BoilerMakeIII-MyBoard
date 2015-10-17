//
//  Constants.swift
//  BoilerMakeIII
//
//  Created by Yi Qin on 10/17/15.
//  Copyright © 2015 Yi Qin. All rights reserved.
//

import Foundation

let leftMargin: CGFloat = 0.04
let rightMargin: CGFloat = 0.04
let topMargin: CGFloat = 0.044
let bottomMargin: CGFloat = 0.022


// MARK: - UI Constant

let screenBounds = UIScreen.mainScreen().bounds
let screenSize   = screenBounds.size
let screenWidth  = screenSize.width
let screenHeight = screenSize.height

let navigationHeight : CGFloat = 44.0
let statubarHeight : CGFloat = 20.0
let navigationHeaderAndStatusbarHeight : CGFloat = navigationHeight + statubarHeight


let xPadding:CGFloat = 10.0
let yPadding:CGFloat = 10.0


let screenshotRatio:CGFloat = 0.5622188905547226

let iosBlue: UIColor = UIColor(red: 0.0, green: 122.0 / 255.0, blue: 1.0, alpha: 1.0)
let iosSelectedBlue: UIColor = UIColor(red: 0.0, green: 122.0 / 255.0, blue: 1.0, alpha: 0.5)

// MARK: - Constant Strings

let deviceFileName = "iOSDevice"
let plistType = "plist"

// MARK: - Reuseable Cells

let mainCellReuseIdentifier = "BMMainMenuCell"

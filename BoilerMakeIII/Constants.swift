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

// In Edit mode, the card view size
let cardViewWidth = screenWidth - 54.0*2.0
let cardViewHeight = cardViewWidth/screenshotRatio

let scaleDownRatio = cardViewWidth/screenWidth


let xPadding:CGFloat = 10.0
let yPadding:CGFloat = 10.0


let screenshotRatio:CGFloat = 0.5622188905547226

let iosBlue: UIColor = UIColor(red: 52.0/255.0, green: 152.0 / 255.0, blue: 219.0/255.0, alpha: 1.0)
let iosRed: UIColor = UIColor(red: 231.0 / 255.0, green: 76.0 / 255.0, blue: 60.0 / 255.0, alpha: 1.0)
let iosYellow: UIColor = UIColor(red: 241.0 / 255.0, green: 196.0 / 255.0, blue: 15.0 / 255.0, alpha: 1.0)
let iosGray: UIColor = UIColor(red: 180.0 / 255.0, green: 180.0 / 255.0, blue: 180.0 / 255.0, alpha: 0.7)
let iosGreen: UIColor = UIColor(red: 46.0 / 255.0, green: 204.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)
let iosSelectedBlue: UIColor = UIColor(red: 0.0, green: 122.0 / 255.0, blue: 1.0, alpha: 0.5)

// MARK: - Constant Strings

let deviceFileName = "iOSDevice"
let plistType = "plist"

// MARK: - Reuseable Cells

let mainCellReuseIdentifier = "BMMainMenuCell"

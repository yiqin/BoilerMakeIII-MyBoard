//
//  ScrollViewContainer.swift
//  BoilerMakeIII
//
//  Created by Yi Qin on 10/17/15.
//  Copyright © 2015 Yi Qin. All rights reserved.
//

import UIKit

class ScrollViewContainer: UIView {
    
    
    var scrollView:UIScrollView = UIScrollView()
    
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, withEvent: event)
        
        if view == self {
            return scrollView
        }
        return view
    }
    
}

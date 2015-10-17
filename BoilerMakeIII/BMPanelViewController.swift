//
//  BMPanelViewController.swift
//  BoilerMakeIII
//
//  Created by Yifan Xiao on 10/17/15.
//  Copyright © 2015 Yi Qin. All rights reserved.
//

import UIKit

class BMPanelViewController: UIViewController {
    
    enum State {
        case Play
        case Edit
    }
    
    // Play or Edit
    // let state: State!
    
    // Identifier which page or which view in the storyboard.
    // let identifier: String
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        view.backgroundColor = UIColor.redColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

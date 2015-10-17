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
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "removeViewController", name: SVProgressHUDDidDisappearNotification, object: nil)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let firstOne = BMStoryboardDataManager.sharedInstance.testData()
        firstOne.view.frame = CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))
        self.addChildViewController(firstOne)
        view.addSubview(firstOne.view)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        self.resignFirstResponder()
        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if (motion == UIEventSubtype.MotionShake)
        {

            let title = "More"
            let preButtonTitle = "Last"
            let nextButtonTitle  = "Next"
            let backButtonTitle = "Back"
            
            let alertController = DOAlertController(title: title, message: nil, preferredStyle: .Alert)
            
            let preAction = DOAlertAction(title: preButtonTitle, style: .Default) { action in
                
                alertController.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                    //TO-DO: to add the code lead to last view controller
                    
                })
            }
            
            let nextAction = DOAlertAction(title: nextButtonTitle, style: .Default) { action in
                
                alertController.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                    //TO-DO: to add the code lead to next view controller
                    
                })
                
                
            }
            
            let backAction = DOAlertAction(title: backButtonTitle, style: .Cancel) { action in
                
                alertController.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                    self.removeViewController()
                })
                
            }
            
            alertController.addAction(preAction)
            alertController.addAction(nextAction)
            alertController.addAction(backAction)
            
            presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    
    
    func removeViewController(){

        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}

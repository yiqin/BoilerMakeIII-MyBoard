//
//  BMPanelViewController.swift
//  BoilerMakeIII
//
//  Created by Yifan Xiao on 10/17/15.
//  Copyright © 2015 Yi Qin. All rights reserved.
//
import UIKit

var shakingIndex = 0

class BMPanelViewController: UIViewController {

    // Play or Edit
    // let state: State!
    
    // Identifier which page or which view in the storyboard.
    // let identifier: String
    
    var app: BMApplication = BMStoryboardDataManager.sharedInstance.applications.objectAtIndex(0) as! BMApplication
    
    var hostNavigationController = UINavigationController(nibName: nil, bundle: nil)
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "removeViewController", name: SVProgressHUDDidDisappearNotification, object: nil)
        
        shakingIndex = 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.whiteColor()
        
        if app.viewControllers.count != 0 {
            
            let vc = app.viewControllers.objectAtIndex(shakingIndex) as! BMTemplateViewController
            
            hostNavigationController.viewControllers = [vc]
            
            hostNavigationController.view.frame = CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))
            self.addChildViewController(hostNavigationController)
            view.addSubview(hostNavigationController.view)
        }
        
        
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
            let preButtonTitle = "Previous View Controller"
            let nextButtonTitle  = "Next View Controller"
            let backButtonTitle = "Back"
            
            let alertController = DOAlertController(title: title, message: nil, preferredStyle: .Alert)
            
            let preAction = DOAlertAction(title: preButtonTitle, style: .Default) { action in
                
                alertController.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                    //TO-DO: to add the code lead to last view controller
                    
                    shakingIndex = shakingIndex - 1
                    if shakingIndex < 0 {
                        shakingIndex = 0
                    } else {
                        let vc = self.app.viewControllers.objectAtIndex(shakingIndex) as! BMTemplateViewController
                        self.hostNavigationController.viewControllers = [vc]
                    }
                    
                    
                })
            }
            
            let nextAction = DOAlertAction(title: nextButtonTitle, style: .Default) { action in
                
                alertController.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                    //TO-DO: to add the code lead to next view controller
                    
                    shakingIndex = shakingIndex + 1
                    if shakingIndex > self.app.viewControllers.count-1 {
                        shakingIndex = self.app.viewControllers.count-1
                    } else {
                        let vc = self.app.viewControllers.objectAtIndex(shakingIndex) as! BMTemplateViewController
                        self.hostNavigationController.viewControllers = [vc]
                    }
                    
                    
                })
                
                
            }
            
            let backAction = DOAlertAction(title: backButtonTitle, style: .Cancel) { action in
                
                alertController.dismissViewControllerAnimated(true, completion: { () -> Void in
                    nextViewControllerID = 1
                    shakingIndex = 0
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

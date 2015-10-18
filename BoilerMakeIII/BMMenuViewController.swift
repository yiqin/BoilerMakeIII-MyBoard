//
//  BMMenuViewController.swift
//  BoilerMakeIII
//
//  Created by Yifan Xiao on 10/17/15.
//  Copyright © 2015 Yi Qin. All rights reserved.
//

import UIKit


class BMMenuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate{
    
    
@IBOutlet weak var menuCollectionView: UICollectionView!
    
    weak var NameTextField: UITextField?
    
    var collectionData: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        let path = NSBundle.mainBundle().pathForResource(deviceFileName, ofType: plistType)
        let dict = NSDictionary(contentsOfFile: path!)
        
        collectionData = dict!.objectForKey("iOSDevice") as! [String]
        
        let newAPPButton = UIBarButtonItem(title: "New", style: .Plain, target: self, action: "pressNewAppButton:")
        navigationItem.rightBarButtonItem = newAPPButton
    }

    func pressNewAppButton(sender: UIBarButtonItem) {
        
        /// Show a custom alert.
        func showCustomAlert(_: NSIndexPath) {
            let title = "Input New app name"
            let cancelButtonTitle = "Cancel"
            let otherButtonTitle = "Done"
            
            var customAlertController: DOAlertController!
            
            customAlertController = DOAlertController(title: title, message: nil, preferredStyle: .Alert)
            
            // OverlayView
            customAlertController.overlayColor = UIColor(red:235/255, green:245/255, blue:255/255, alpha:0.7)
            // AlertView
            customAlertController.alertViewBgColor = UIColor(red:44/255, green:62/255, blue:80/255, alpha:1)
            // Title
            customAlertController.titleFont = UIFont(name: "GillSans-Bold", size: 18.0)
            customAlertController.titleTextColor = UIColor(red:241/255, green:196/255, blue:15/255, alpha:1)
            // Message
            customAlertController.messageFont = UIFont(name: "GillSans-Italic", size: 15.0)
            customAlertController.messageTextColor = UIColor.whiteColor()
            // Cancel Button
            customAlertController.buttonFont[.Cancel] = UIFont(name: "GillSans-Bold", size: 16.0)
            // Default Button
            customAlertController.buttonFont[.Default] = UIFont(name: "GillSans-Bold", size: 16.0)
            customAlertController.buttonTextColor[.Default] = UIColor(red:44/255, green:62/255, blue:80/255, alpha:1)
            customAlertController.buttonBgColor[.Default] = UIColor(red: 46/255, green:204/255, blue:113/255, alpha:1)
            customAlertController.buttonBgColorHighlighted[.Default] = UIColor(red:64/255, green:212/255, blue:126/255, alpha:1)
            
            
            customAlertController.addTextFieldWithConfigurationHandler { textField in
                self.NameTextField = textField
                textField.placeholder = "new name"
                textField.frame.size = CGSizeMake(240.0, 30.0)
                textField.font = UIFont(name: "Avenir Next", size: 15.0)
                textField.keyboardAppearance = UIKeyboardAppearance.Dark
                textField.returnKeyType = UIReturnKeyType.Next
                
                let label:UILabel = UILabel(frame: CGRectMake(0, 0, 50, 30))
                label.text = "name"
                label.font = UIFont(name: "GillSans-Bold", size: 15.0)
                textField.leftView = label
                textField.leftViewMode = UITextFieldViewMode.Always
                
                textField.delegate = self
            }
            
                        
            // Create the actions.
            let cancelAction = DOAlertAction(title: cancelButtonTitle, style: .Cancel) { action in
                NSLog("The \"Custom\" alert's cancel action occured.")
            }
            
            let confirmAction = DOAlertAction(title: otherButtonTitle, style: .Default) { action in
                NSLog("The \"Custom\" alert's other action occured.")
                
                let textFields = customAlertController.textFields as? Array<UITextField>
                if textFields != nil {
                    for textField: UITextField in textFields! {
                       
                        //TO-DO: The place to get the new app name
                        
                        
                    }
                }
            }
            
            // Add the actions.
            customAlertController.addAction(cancelAction)
            customAlertController.addAction(confirmAction)
            
            presentViewController(customAlertController, animated: true, completion: nil)
        }

        
        
        
        
        BMStoryboardDataManager.sharedInstance.applications.addObject(BMApplication())
        menuCollectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.menuCollectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(mainCellReuseIdentifier, forIndexPath: indexPath) as! BMMenuCollectionViewCell
        
        let app = BMStoryboardDataManager.sharedInstance.applications[indexPath.row] as! BMApplication
        
        cell.cellTextLabel.text = app.title as String
        cell.cellImage.image = UIImage(named: "\(collectionData[1]).png")
        
        cell.contentView.layer.cornerRadius = 12.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clearColor().CGColor
        cell.contentView.layer.masksToBounds = true
        
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BMStoryboardDataManager.sharedInstance.applications.count;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width = (self.view.frame.size.width - 22.0)/2.0
        
     return CGSize(width: width, height: width)
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
            let scaleDownAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
            scaleDownAnimation.fromValue = NSValue(CGSize: CGSizeMake(0.95, 0.95))
            scaleDownAnimation.springBounciness = 18;
            scaleDownAnimation.toValue = NSValue(CGSize: CGSizeMake(1.0, 1.0))
            let selectedCell = collectionView.cellForItemAtIndexPath(indexPath) as! BMMenuCollectionViewCell
        
            selectedCell.highlighted = true
            self.view.userInteractionEnabled = false
            selectedCell.cellImage.layer.pop_addAnimation(scaleDownAnimation, forKey: "scaleAnimation")
        
            scaleDownAnimation.completionBlock = {(animation, finished) in

                self.view.userInteractionEnabled = true
                
                self.showOkayCancelAlert(indexPath)
            }
        
    }
    
    func showOkayCancelAlert(indexPath: NSIndexPath) {
        let title = "Select the action"
        let editButtonTitle = "Edit"
        let playButtonTitle = "Play"
        let cancelButtonTitle = "Cancel"
        
        let alertCotroller = DOAlertController(title: title, message: nil, preferredStyle: .Alert)
        
        let editAction = DOAlertAction(title: editButtonTitle, style: .Default) { action in
            
            alertCotroller.dismissViewControllerAnimated(true, completion: { () -> Void in
                
                // FIXEDME: Push or pop?
                
                let vc = BMEditStoryboardViewController()
                vc.app = BMStoryboardDataManager.sharedInstance.applications[indexPath.row] as! BMApplication
                self.navigationController?.pushViewController(vc, animated: true)
                
            })
        
            
        }
        
        let playAction = DOAlertAction(title: playButtonTitle, style: .Default) { action in
            
            alertCotroller.dismissViewControllerAnimated(true, completion: { () -> Void in
               
                
                let readyApp = BMStoryboardDataManager.sharedInstance.applications[indexPath.row] as! BMApplication
                
                if readyApp.viewControllers.count != 0 {
                    let vc = BMPanelViewController()
                    vc.app = readyApp
                    self.presentViewController(vc, animated: true, completion: nil)
                }
                else {
                    
                    self.showSimpleAlert()
                    
                }
                
         
            })
            
            
        }
        
        let cancelAction = DOAlertAction(title: cancelButtonTitle, style: .Cancel) { action in
            alertCotroller.dismissViewControllerAnimated(true, completion: nil)
        }
        
        // Add the actions.
        alertCotroller.addAction(editAction)
        alertCotroller.addAction(playAction)
        alertCotroller.addAction(cancelAction)
        
        presentViewController(alertCotroller, animated: true, completion: nil)
    }
    
    func showSimpleAlert() {
        let title = "Tips"
        let message = "Use Edit mode to give your app the first view"
        let cancelButtonTitle = "OK"
        
        let alertController = DOAlertController(title: title, message: message, preferredStyle: .Alert)
        
        // Create the action.
        let cancelAction = DOAlertAction(title: cancelButtonTitle, style: .Cancel) { action in
            NSLog("The simple alert's cancel action occured.")
        }
        
        // Add the action.
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

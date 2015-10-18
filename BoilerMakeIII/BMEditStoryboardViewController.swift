//
//  BMEditStoryboardViewController.swift
//  BoilerMakeIII
//
//  Created by Yi Qin on 10/17/15.
//  Copyright © 2015 Yi Qin. All rights reserved.
//

import UIKit

class BMEditStoryboardViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var customAlertController: DOAlertController!
    weak var textField1: UITextField?
    weak var textField2: UITextField?
    weak var textField3: UITextField?
    weak var textField4: UITextField?
    weak var customAlertAction: DOAlertAction?
    
    let viewControllersScrollView: JT3DScrollView = JT3DScrollView()
    
    let libraryView: UIView = UIView()
    
    var movingView: UIView? = nil
    
    var availableComponents = [UILibraryComponent]()
    
    var currentIndex = 0
    
    var currentImageView = UIImageView()
    
    var currentLabel = UILabel()
    
    var selectedView: UIView? = nil
    
    var app = BMStoryboardDataManager.sharedInstance.applications.objectAtIndex(0) as! BMApplication
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleComponentTapped:", name: "BMEditComponentTapped", object: nil)
    }
    
    func createUILibrary() {
        let label = UILibraryComponent(title:"Label", type: .Label)
        let button = UILibraryComponent(title:"Button", type: .Button)
        let imageView = UILibraryComponent(title:"Image View", type: .ImageView)
        
        availableComponents = [label, button, imageView]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.clipsToBounds = true
        
        createUILibrary()
        
        view.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        
        let newPageButton = UIBarButtonItem(title: "New View", style: .Plain, target: self, action: "pressedNewViewButton")
        navigationItem.rightBarButtonItem = newPageButton
        
        setupLibraryView()
        
        // Bind gesture recognizer
        bindGestureRecognizer()
    }

    func bindGestureRecognizer() {
        currentLabel.userInteractionEnabled = true
        let gestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        gestureRecognizer.delegate = self
        currentLabel.addGestureRecognizer(gestureRecognizer)
    }
    
    func handlePan(sender: UIPanGestureRecognizer) {
        if let view = sender.view {
            switch sender.state {
            case .Began:
                createMoving(sender.locationInView(self.view))
                self.view.addSubview(movingView!)
                print("began")
                break
            case .Changed:
                let offset: CGPoint = sender.translationInView(self.view)
                movingView?.center = CGPoint(x: (movingView?.center.x)! + offset.x, y: (movingView?.center.y)! + offset.y)
                sender.setTranslation(CGPoint.zero, inView: self.view)
                print("changed")
                break
            case .Ended:
                if let moving = movingView {
                    let pageIndex: Int = Int(self.viewControllersScrollView.currentPage())
                    let currentViewController = app.viewControllers.objectAtIndex(pageIndex) as! BMTemplateViewController
                    
                    let updatedFrame: CGRect = CGRect(x: moving.frame.origin.x + screenWidth * CGFloat(pageIndex), y: moving.frame.origin.y, width: moving.frame.size.width, height: moving.frame.size.height)
                    
                    print(currentViewController.view.frame)
                    print(updatedFrame)
                    
                    // Check intersect
                    if CGRectIntersectsRect(currentViewController.view.frame, updatedFrame) {
                        let newCenter: CGPoint = self.view.convertPoint(moving.center, toView: currentViewController.view)
                        let newView: UIView = getCurrentComponent()
                        newView.center = newCenter
                        
                        currentViewController.bindAndAddSubview(newView)
                    }
                
                    moving.removeFromSuperview()
                    self.movingView = nil
                }
                print("ended")
                break
            default:
                break
            }
        }
    }
    
    func getCurrentComponent() -> UIView {
        switch currentIndex {
        case 0:
            // label
            return BMLabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        case 1:
            // button
            return BMButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        case 2:
            // imageView
            return BMImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        default:
            return BMLabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        }
    }
    
    func createMoving(center: CGPoint) {
        switch currentIndex {
        case 2:
            movingView = UIView(frame: CGRect(x: center.x - 50, y: center.y - 50, width: 100, height: 100))
        default:
            movingView = UIView(frame: CGRect(x: center.x - 50, y: center.y - 25, width: 100, height: 50))
            break;
        }
        movingView?.alpha = 0.5
        movingView?.backgroundColor = iosBlue
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // MARK: - Must be in the viewDidAppear
        
        setupViewControllersScrollView()
        
                
        // let vc = app.viewControllers.objectAtIndex(0) as! BMTemplateViewController
        
        for vc in app.viewControllers {
            if vc is BMTemplateViewController {
                let tempVC = vc as! BMTemplateViewController
                tempVC.changeToEdit()
                createCard(tempVC, ableToAdd: false)
            }
        }
        
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        // Must hide in the view did disappear
        
        
        super.viewDidDisappear(animated)
        
        // MARK: Remove.....
        
        BMStoryboardDataManager.sharedInstance.saveData()
        BMStoryboardDataManager.sharedInstance.loadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // viewControllersScrollView.hidden = true
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func pressedNewViewButton() {
        // FIXEDME: - test create the card.
        createCard(BMTemplateViewController(appID: app.id, vcID: BMStoryboardDataManager.sharedInstance.getNextID(), dictionary: NSDictionary()), ableToAdd: true)
    }
    
    func pressedEmptyButton(sender:UIButton!) {
        sender.backgroundColor = UIColor.blueColor()
        print("press")
    }
    
    
    func dragOutsideEmptyButton(sender:UIButton!) {
        sender.backgroundColor = UIColor.yellowColor()
        print("drag outside")
    }
    
    // MARK: setup viewControllers
    
    func setupViewControllersScrollView() {
        
        viewControllersScrollView.frame = CGRectMake((screenWidth-cardViewWidth)/2, 44, cardViewWidth, cardViewHeight)
        // viewControllersScrollView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        viewControllersScrollView.effect = JT3DScrollViewEffect.Depth
        
        view.addSubview(viewControllersScrollView)
    }
    
    
    func createCard(templateViewController:BMTemplateViewController, ableToAdd: Bool) {
        let width = CGRectGetWidth(viewControllersScrollView.frame)
        let height = CGRectGetHeight(viewControllersScrollView.frame)
        
        let x = CGFloat(viewControllersScrollView.subviews.count) * width
        
        // MARK: - update TemplateViewController...
        
        templateViewController.view.frame = CGRectMake(x, CGRectGetMinY(viewControllersScrollView.frame), width, height)
        
        addChildViewController(templateViewController)
        
        if ableToAdd {
            app.viewControllers.addObject(templateViewController)
        }
        
        viewControllersScrollView.addSubview(templateViewController.view)
        
        viewControllersScrollView.contentSize = CGSizeMake(x+width, height)
    }
    
    
    // MARK: - LibraryView
    
    func setupLibraryView() {
        
        libraryView.frame = CGRectMake(0, CGRectGetHeight(view.frame)-64, screenWidth, 64)
        libraryView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleTopMargin]
        libraryView.backgroundColor = iosRed
        
        view.addSubview(libraryView)

        // Left previous button
        
        let image1 = UIImage(named: "back") as UIImage?
        let previousButton   = UIButton(type: .System)
        previousButton.frame = CGRectMake(0, 0, 64, 64)
        previousButton.setImage(image1, forState: .Normal)
        previousButton.addTarget(self, action: "tappedPreviousButton:", forControlEvents:.TouchUpInside)
        libraryView.addSubview(previousButton)
        
        // Right next button
        
        let image2 = UIImage(named: "forward") as UIImage?
        let nextButton   = UIButton(type: .System)
        nextButton.frame = CGRectMake(screenWidth-64, 0, 64, 64)
        nextButton.setImage(image2, forState: .Normal)
        nextButton.addTarget(self, action: "tappedNextButton:", forControlEvents:.TouchUpInside)
        libraryView.addSubview(nextButton)
        
        // Add currentLabel
        
        currentLabel.text = availableComponents[currentIndex].title
        currentLabel.textAlignment = NSTextAlignment.Center
        currentLabel.frame = CGRectMake(64, 0, screenWidth-64*2, 64)
        
        libraryView.addSubview(currentLabel)
        
    }
    
    func tappedPreviousButton(sender:UIButton!) {
        print("previous button")
        currentIndex--
        if currentIndex < 0 {
            currentIndex = 0
        }
        currentLabel.text = availableComponents[currentIndex].title
    }
    
    func tappedNextButton(sender:UIButton!) {
        print("next button")
        currentIndex++
        if currentIndex > availableComponents.count-1 {
            currentIndex = availableComponents.count-1
        }
        currentLabel.text = availableComponents[currentIndex].title
    }
    
    func handleComponentTapped(notification: NSNotification)
    {
        let userInfo:Dictionary<String,AnyObject!> = notification.userInfo as! Dictionary<String,AnyObject!>
        let viewTag = userInfo["viewTappedTag"]
        
        self.showCustomAlert(viewTag as! NSInteger)
    }
    
    func showCustomAlert(viewTag: NSInteger) {
        print(viewTag)
        
        let currentIndex:Int = Int(self.viewControllersScrollView.currentPage())
        let currentPage = app.viewControllers.objectAtIndex(currentIndex as Int) as! BMTemplateViewController
        
        var currentView :UIView? = nil
        for case let component as BMComponentProtocol in currentPage.view.subviews {
            if (component.id == viewTag)
            {
                currentView = component as? UIView
                break
            }
            
        }
        
        if let view = currentView {
            
            self.selectedView = view
            
            let title = "Component Parameters"
            let message = "Input parameters you want to update"
            let deleteButtonTitle = "Delete"
            let cancelButtonTitle = "Cancel"
            let otherButtonTitle = "Comfirm"
            let pickPhotoTitle = "Choose Photo"
            
            customAlertController = DOAlertController(title: title, message: message, preferredStyle: .Alert)
            
            // OverlayView
            customAlertController.overlayColor = UIColor(red:235/255, green:245/255, blue:255/255, alpha:0.7)
            // AlertView
            customAlertController.alertViewBgColor = UIColor(red:44/255, green:62/255, blue:80/255, alpha:1)
            // Title
            customAlertController.titleFont = UIFont(name: "Avenir Next", size: 18.0)
            customAlertController.titleTextColor = UIColor(red:241/255, green:196/255, blue:15/255, alpha:1)
            // Message
            customAlertController.messageFont = UIFont(name: "Avenir Next", size: 15.0)
            customAlertController.messageTextColor = UIColor.whiteColor()
            // Cancel Button
            customAlertController.buttonFont[.Cancel] = UIFont(name: "Avenir Next", size: 16.0)
            // Default Button
            customAlertController.buttonFont[.Default] = UIFont(name: "Avenir Next", size: 16.0)
            customAlertController.buttonTextColor[.Default] = UIColor(red:44/255, green:62/255, blue:80/255, alpha:1)
            customAlertController.buttonBgColor[.Default] = UIColor(red: 46/255, green:204/255, blue:113/255, alpha:1)
            customAlertController.buttonBgColorHighlighted[.Default] = UIColor(red:64/255, green:212/255, blue:126/255, alpha:1)
            
            
            customAlertController.addTextFieldWithConfigurationHandler { textField in
                self.textField1 = textField
                textField.placeholder = "x"
                textField.frame.size = CGSizeMake(240.0, 30.0)
                textField.font = UIFont(name: "Avenir Next", size: 15.0)
                textField.keyboardAppearance = UIKeyboardAppearance.Dark
                textField.returnKeyType = UIReturnKeyType.Next
                textField.text = String(view.frame.origin.x)
                
                let label:UILabel = UILabel(frame: CGRectMake(0, 0, 50, 30))
                label.text = "x"
                label.font = UIFont(name: "Avenir Next", size: 15.0)
                textField.leftView = label
                textField.leftViewMode = UITextFieldViewMode.Always
                
                textField.delegate = self
            }
            
            customAlertController.addTextFieldWithConfigurationHandler { textField in
                self.textField2 = textField
                textField.placeholder = "y"
                textField.frame.size = CGSizeMake(240.0, 30.0)
                textField.font = UIFont(name: "Avenir Next", size: 15.0)
                textField.keyboardAppearance = UIKeyboardAppearance.Dark
                textField.returnKeyType = UIReturnKeyType.Send
                textField.text = String(view.frame.origin.y)
                
                let label:UILabel = UILabel(frame: CGRectMake(0, 0, 50, 30))
                label.text = "y"
                label.font = UIFont(name: "Avenir Next", size: 15.0)
                textField.leftView = label
                textField.leftViewMode = UITextFieldViewMode.Always
                
                textField.delegate = self
            }
            
            customAlertController.addTextFieldWithConfigurationHandler { textField in
                self.textField3 = textField
                textField.placeholder = "width"
                textField.frame.size = CGSizeMake(240.0, 30.0)
                textField.font = UIFont(name: "Avenir Next", size: 15.0)
                textField.keyboardAppearance = UIKeyboardAppearance.Dark
                textField.returnKeyType = UIReturnKeyType.Send
                textField.text = String(view.frame.size.width)
                
                let label:UILabel = UILabel(frame: CGRectMake(0, 0, 50, 30))
                label.text = "width"
                label.font = UIFont(name: "Avenir Next", size: 15.0)
                textField.leftView = label
                textField.leftViewMode = UITextFieldViewMode.Always
                
                textField.delegate = self
            }
            
            customAlertController.addTextFieldWithConfigurationHandler { textField in
                self.textField4 = textField
                textField.placeholder = "height"
                textField.frame.size = CGSizeMake(240.0, 30.0)
                textField.font = UIFont(name: "Avenir Next", size: 15.0)
                textField.keyboardAppearance = UIKeyboardAppearance.Dark
                textField.returnKeyType = UIReturnKeyType.Send
                textField.text = String(view.frame.size.height)

                
                let label:UILabel = UILabel(frame: CGRectMake(0, 0, 50, 30))
                label.text = "height"
                label.font = UIFont(name: "Avenir Next", size: 15.0)
                textField.leftView = label
                textField.leftViewMode = UITextFieldViewMode.Always
                
                textField.delegate = self
            }
            
            let deleteAction = DOAlertAction(title: deleteButtonTitle, style: .Destructive) { action in
                NSLog("The \"Custom\" alert's other action occured.")
                
                view.removeFromSuperview()
                
                
            }
            
            // Create the actions.
            let cancelAction = DOAlertAction(title: cancelButtonTitle, style: .Cancel) { action in
                NSLog("The \"Custom\" alert's cancel action occured.")
            }
            
            let confirmAction = DOAlertAction(title: otherButtonTitle, style: .Default) { action in
                self.updateDic()
            }
            customAlertAction = confirmAction
            
            let takePictureAction = DOAlertAction(title: pickPhotoTitle, style: .Default) { action in
                
                self.currentImageView = (self.selectedView as? UIImageView)!
                
                let picker: UIImagePickerController = UIImagePickerController()
                picker.delegate = self
                picker.allowsEditing = true
                picker.sourceType = .PhotoLibrary
                
                self.customAlertController.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                    self.presentViewController(picker, animated: true, completion: nil)
                    
                })
                
            }
            
            customAlertController.addAction(confirmAction)
            
            
            if (view.isKindOfClass(UIImageView))
            {
             customAlertController.addAction(takePictureAction)
            }
            
            customAlertController.addAction(deleteAction)
            customAlertController.addAction(cancelAction)
            
            
            presentViewController(customAlertController, animated: true, completion: nil)
            
        }
        
        
        
    }
    
    func updateDic(){
        
        let textFields = self.customAlertController.textFields as? Array<UITextField>
        if (textFields != nil) {
            for textField: UITextField in textFields! {
                NSLog("  \(textField.placeholder!): \(textField.text)")
                let value: CGFloat = CGFloat((textField.text! as NSString).floatValue)
                if let fieldName = textField.placeholder, let view = self.selectedView {
                    switch fieldName {
                    case "x":
                        view.frame.origin.x = value
                        break;
                    case "y":
                        view.frame.origin.y = value
                        break;
                    case "width":
                        view.frame.size.width = value
                        break;
                    case "height":
                        view.frame.size.height = value
                        break
                    default:
                        break;
                    }
                }
            }
        }
        
    }
    

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let chosenImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            let pngData: NSData = UIImagePNGRepresentation(chosenImage)!
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
            let imageFilename = "\(dateFormatter.stringFromDate(NSDate())).png"
            
            // Update filename and image.
            let imageView: BMImageView = currentImageView as! BMImageView
            imageView.image = UIImage(data: pngData)
            imageView.filename = imageFilename
            
            // Write image data to file.
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
            let documentsDirectory = paths.objectAtIndex(0) as! NSString
            let path = documentsDirectory.stringByAppendingPathComponent(imageFilename)
            print("Save image: \(path)")
            pngData.writeToFile(path, atomically: false)
        }
        
        picker.dismissViewControllerAnimated(true) { () -> Void in
            
            self.setupViewControllersScrollView()
        }
    }
    
}

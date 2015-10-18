//
//  BMEditStoryboardViewController.swift
//  BoilerMakeIII
//
//  Created by Yi Qin on 10/17/15.
//  Copyright © 2015 Yi Qin. All rights reserved.
//

import UIKit

class BMEditStoryboardViewController: UIViewController {
    
    let viewControllersScrollView: JT3DScrollView = JT3DScrollView()
    
    let libraryView: UIView = UIView()
    
    var availableComponents = [UILibraryComponent]()
    
    var currentIndex = 0
    
    var previousLabel = UILabel()
    var currentLabel = UILabel()
    var nextLabel = UILabel()
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
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
        
        createUILibrary()
        
        view.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        
        let saveButton = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: "pressedSaveButton")
        navigationItem.rightBarButtonItem = saveButton
        
        setupLibraryView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // MARK: - Must be in the viewDidAppear
        
        setupViewControllersScrollView()
        
        
        let app = BMStoryboardDataManager.sharedInstance.applications.objectAtIndex(0) as! BMApplication
        
        // let vc = app.viewControllers.objectAtIndex(0) as! BMTemplateViewController
        
        for vc in app.viewControllers {
            createCard(vc as! BMTemplateViewController)
        }
        
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        
        // Must hide in the view did disappear
        viewControllersScrollView.hidden = true
        
        super.viewDidDisappear(animated)
        
        // MARK: Remove.....
        
        BMStoryboardDataManager.sharedInstance.saveData()
        BMStoryboardDataManager.sharedInstance.loadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    func pressedSaveButton() {
        
        print("pressed Save Button")
        
        // FIXEDME: - test create the card.
        // createCard()
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
    
    
    func createCard(templateViewController:BMTemplateViewController) {
        let width = CGRectGetWidth(viewControllersScrollView.frame)
        let height = CGRectGetHeight(viewControllersScrollView.frame)
        
        let x = CGFloat(viewControllersScrollView.subviews.count) * width
        
        // MARK: - update TemplateViewController...
        
        templateViewController.view.frame = CGRectMake(x, CGRectGetMinY(viewControllersScrollView.frame), width, height)
        
        addChildViewController(templateViewController)
        viewControllersScrollView.addSubview(templateViewController.view)
        
        viewControllersScrollView.contentSize = CGSizeMake(x+width, height)
    }
    
    
    // MARK: - LibraryView
    
    func setupLibraryView() {
        
        libraryView.frame = CGRectMake(0, CGRectGetHeight(view.frame)-64, screenWidth, 64)
        libraryView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleTopMargin]
        libraryView.backgroundColor = UIColor.redColor()
        
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
    
}

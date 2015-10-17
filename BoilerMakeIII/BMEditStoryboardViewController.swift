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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    func createUILibrary() {
        let label = UILibraryComponent(title:"Label")
        let button = UILibraryComponent(title:"Button")
        let imageView = UILibraryComponent(title:"Image View")
        let label1 = UILibraryComponent(title: "Label1")
        
        availableComponents = [label, label1, button, imageView, label1]
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
        
        createCard()
        createCard()
        createCard()
        createCard()
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        // Must hide in the view did disappear
        viewControllersScrollView.hidden = true
        
        super.viewDidDisappear(animated)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    func pressedSaveButton() {
        
        print("pressed Save Button")
        
        // FIXEDME: - test create the card.
        createCard()
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
    
    
    func createCard() {
        let width = CGRectGetWidth(viewControllersScrollView.frame)
        let height = CGRectGetHeight(viewControllersScrollView.frame)
        
        let x = CGFloat(viewControllersScrollView.subviews.count) * width
        
        // MARK: - update TemplateViewController...
        
        let firstVC = BMTemplateViewController(appID: 10, vcID: 8)
        firstVC.view.frame = CGRectMake(x, CGRectGetMinY(viewControllersScrollView.frame), width, height)
        
        addChildViewController(firstVC)
        viewControllersScrollView.addSubview(firstVC.view)
        
        viewControllersScrollView.contentSize = CGSizeMake(x+width, height)
    }
    
    
    // MARK: - LibraryView
    
    func setupLibraryView() {
        
        libraryView.frame = CGRectMake(0, CGRectGetHeight(view.frame)-64, CGRectGetWidth(view.frame), 64)
        libraryView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleTopMargin]
        libraryView.backgroundColor = UIColor.redColor()
        
        view.addSubview(libraryView)

        // Left previous button
        
        let image1 = UIImage(named: "name") as UIImage?
        let previousButton   = UIButton(type: .System)
        previousButton.frame = CGRectMake(0, 0, 64, 64)
        previousButton.setImage(image1, forState: .Normal)
        previousButton.addTarget(self, action: "tappedPreviousButton:", forControlEvents:.TouchUpInside)
        libraryView.addSubview(previousButton)
        
        // Right next button
        
        let image2 = UIImage(named: "name") as UIImage?
        let nextButton   = UIButton(type: .System)
        nextButton.frame = CGRectMake(screenWidth-64, 0, 64, 64)
        nextButton.setImage(image2, forState: .Normal)
        nextButton.addTarget(self, action: "tappedNextButton:", forControlEvents:.TouchUpInside)
        libraryView.addSubview(nextButton)
    }
    
    func tappedPreviousButton(sender:UIButton!) {
        print("previous button")
    }
    
    func tappedNextButton(sender:UIButton!) {
        print("next button")
    }
    
}

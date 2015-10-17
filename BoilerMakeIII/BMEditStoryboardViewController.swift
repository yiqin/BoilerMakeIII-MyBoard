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
    
    
    var scrollView:UIScrollView = UIScrollView()
    var scrollViewContainer:ScrollViewContainer = ScrollViewContainer()
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        
    }
    
    func createUILibrary() {
        
        
        let viewsToRemove = scrollView.subviews
        for v in viewsToRemove {
            v.removeFromSuperview()
        }
        
        let label = UILibraryComponent(title:"Label")
        let button = UILibraryComponent(title:"Button")
        let imageView = UILibraryComponent(title:"Image View")
        let label1 = UILibraryComponent(title: "Label1")
        
        let components = [label, label1, button, imageView, label1]
        
        
        let tempWidth = screenWidth/2
        let imageHeight:CGFloat = 64
        
        let componentCount:CGFloat = 4.0
        
        scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.frame)*componentCount, imageHeight)
        print(imageHeight)
        
        var xPosition: CGFloat = xPadding*0.25
        
        for component in components {
            let tempView = UIView(frame: CGRectMake(xPosition, 0, CGRectGetWidth(scrollView.frame), imageHeight))
            
            tempView.backgroundColor = UIColor.redColor()// UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 244.0/255.0, alpha: 1.0)
            tempView.clipsToBounds = true
            tempView.layer.cornerRadius = 2.0
            
            let tempTitleLabel = UILabel(frame: CGRectMake(xPosition, 0, CGRectGetWidth(tempView.frame), imageHeight))
            tempTitleLabel.text = component.title
            
            
            
            scrollView.addSubview(tempView)
            
            scrollView.addSubview(tempTitleLabel)
            
            xPosition = xPosition+xPadding*0.5+CGRectGetWidth(scrollView.frame)
        }
        scrollView.setContentOffset(CGPointMake(0, 0), animated: false)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        
        let saveButton = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: "pressedSaveButton")
        navigationItem.rightBarButtonItem = saveButton
        
        

        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // MARK: - Must be in the viewDidAppear
        
        setupViewControllersScrollView()
        
        createCard()
        createCard()
        createCard()
        createCard()
        
        
        //
        
        let tempWidth = screenWidth / 2
        let imageHeight:CGFloat = 64
        
        scrollView.frame = CGRectMake(xPadding, 0, tempWidth-xPadding*2, imageHeight)
        scrollView.clipsToBounds = false
        scrollView.pagingEnabled = true
        scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, +15, 0)
        
        scrollViewContainer.frame = CGRectMake(0, screenHeight - (64+10), screenWidth,  imageHeight)
        scrollViewContainer.scrollView = scrollView
        scrollViewContainer.addSubview(scrollView)
        view.addSubview(scrollViewContainer)
        
        
        createUILibrary()
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
    

}

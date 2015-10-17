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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        
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

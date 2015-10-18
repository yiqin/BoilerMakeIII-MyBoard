//
//  BMTemplateViewController.swift
//  BoilerMakeIII
//
//  Created by Yi Qin on 10/17/15.
//  Copyright © 2015 Yi Qin. All rights reserved.
//

import UIKit

enum State {
    case Play
    case Edit
}

var nextViewControllerID = 1

class BMTemplateViewController: UIViewController, BMComponentProtocol {
    
    var isNew = false
    
    var type = BMComponentType.ViewController
    var dictionary: NSDictionary {
        let dict: NSMutableDictionary = NSMutableDictionary()
        for case let component as BMComponentProtocol in self.view.subviews {
            let compDict: NSDictionary = component.dictionary
            dict.setObject(compDict, forKey: String(compDict.objectForKey("id")!))
        }
        let vcDict: NSMutableDictionary = NSMutableDictionary()
        vcDict.setObject(dict, forKey: "UIData")
        vcDict.setObject(id, forKey: "id")
        vcDict.setObject(title!, forKey: "title")
        vcDict.setObject(self.type.rawValue, forKey: "type")
        return NSDictionary(dictionary: vcDict)
    }
    
    var viewcontrollerDict: NSDictionary
    
    var id: Int
    var appID: Int
    
    var state: State = .Play
    
    // Reconstructor.
    init(appID: Int, vcID: Int, dictionary: NSDictionary, state: State = .Play) {
        self.appID = appID
        self.id = vcID
        self.viewcontrollerDict = dictionary
        self.state = state
        
        super.init(nibName: nil, bundle: nil)
        
        if true {

            self.title = viewcontrollerDict["title"] as? String
            if let dict = viewcontrollerDict["UIData"] as? NSDictionary {

                for (_, comp) in dict {
                    let compDict: NSDictionary = comp as! NSDictionary
                    let frame = rectFromDict(compDict)
                    
                    switch compDict["type"] as! NSString {
                    case BMComponentType.Label.rawValue:
                        let label = BMLabel(frame: frame, dict: compDict)
                        label.tag = label.id
                        
                        if state == .Play {
                            
                        } else {
//                            let singleTap = UITapGestureRecognizer(target: self, action: "handleSingleTapElement:")
//                            label.addGestureRecognizer(singleTap)
//                            label.userInteractionEnabled = true
                            bindAndAddSubview(label)
                        }
//                        
                        self.view.addSubview(label)
                        print(label.dictionary)
                        break
                    case BMComponentType.Button.rawValue:
                        let button = BMButton(frame: frame, dict: compDict)
                        button.tag = button.id
                        
                        if state == .Play {
                            button.addTarget(self, action: "tapButton:", forControlEvents: .TouchUpInside)
                        } else {
                            
//                            let singleTap = UITapGestureRecognizer(target: self, action: "handleSingleTapElement:")
//                            button.addGestureRecognizer(singleTap)
//                            button.userInteractionEnabled = true
                            bindAndAddSubview(button)
                        }
                        
                        self.view.addSubview(button)
                        print(button.dictionary)
                        break;
                    case BMComponentType.ImageView.rawValue:
                        let imageView = BMImageView(frame: frame, dict: compDict)
                        imageView.tag = imageView.id
                        
                        self.view.addSubview(imageView)
                        
                        if state == .Play {
                            
                        } else {
//                            
//                            let singleTap = UITapGestureRecognizer(target: self, action: "handleSingleTapElement:")
//                            imageView.addGestureRecognizer(singleTap)
//                            imageView.userInteractionEnabled = true
                            bindAndAddSubview(imageView)
                        }
                        
                        break;
                    default:
                        break
                    }
                }
            print(self.dictionary)
        } else {
            self.title = "ViewController-\(vcID)"
        }
            
        } else {
            print("WARNING: Couldn't create dictionary from UIData.plist! Default values will be used!")
        }
    }
    
    func changeToEdit() {
        
        let viewsToRemove = view.subviews
        for v in viewsToRemove {
            v.removeFromSuperview()
        }
        
        let state = State.Edit
                
        if true {
            self.title = viewcontrollerDict["title"] as? String
            if let dict = viewcontrollerDict["UIData"] as? NSDictionary {
                
                let navFrame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width * scaleDownRatio, height: 44 * scaleDownRatio)
                let navLabel = UILabel.init(frame: navFrame)
                navLabel.text = "navigaton bar"
                navLabel.backgroundColor = iosGray
                navLabel.font = UIFont(name: "Avenir Next", size: navLabel.font.pointSize * scaleDownRatio)
                navLabel.textAlignment = .Center
                self.view.addSubview(navLabel)
                print(navLabel)

                for (_, comp) in dict {
                    let compDict: NSDictionary = comp as! NSDictionary
                    // let frame = rectFromDict(compDict)
                    let frame = scaleDown(compDict)
                    
                    switch compDict["type"] as! NSString {
                    case BMComponentType.Label.rawValue:
                        let label = BMLabel(frame: frame, dict: compDict)
                        label.tag = label.id
                        
                        label.setStoryboardState(.Edit)
                        
                        label.font = UIFont(name: label.font.fontName, size: label.font.pointSize*scaleDownRatio)
                        
                        if state == .Play {
                            
                        } else {
                            bindAndAddSubview(label)
//                            let singleTap = UITapGestureRecognizer(target: self, action: "handleSingleTapElement:")
//                            label.addGestureRecognizer(singleTap)
//                            label.userInteractionEnabled = true
                        }
                        
                        self.view.addSubview(label)
                        print(label.dictionary)
                        break
                    case BMComponentType.Button.rawValue:
                        let button = BMButton(frame: frame, dict: compDict)
                        button.tag = button.id
                        
                        button.setStoryboardState(.Edit)
                        
                        if state == .Play {
                            button.addTarget(self, action: "tapButton:", forControlEvents: .TouchUpInside)
                        } else {
                            bindAndAddSubview(button)
//                            let singleTap = UITapGestureRecognizer(target: self, action: "handleSingleTapElement:")
//                            button.addGestureRecognizer(singleTap)
//                            button.userInteractionEnabled = true
                            
                        }
                        
                        self.view.addSubview(button)
                        print(button.dictionary)
                        break;
                    case BMComponentType.ImageView.rawValue:
                        let imageView = BMImageView(frame: frame, dict: compDict)
                        imageView.tag = imageView.id
                        
                        imageView.setStoryboardState(.Edit)
                        
                        
                        self.view.addSubview(imageView)
                        
                        if state == .Play {
                            
                        } else {
                            bindAndAddSubview(imageView)
//                            let singleTap = UITapGestureRecognizer(target: self, action: "handleSingleTapElement:")
//                            imageView.addGestureRecognizer(singleTap)
//                            imageView.userInteractionEnabled = true
                            
                        }
                        
                        break;
                    default:
                        break
                    }
                }
                print(self.dictionary)
            } else {
                // self.title = "ViewController-\(vcID)"
            }
            
        } else {
            print("WARNING: Couldn't create dictionary from UIData.plist! Default values will be used!")
        }

    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
    }
    
    
    
    // MARK: Helper Functions
    
    func rectFromDict(dict: NSDictionary) -> CGRect {
        let x: CGFloat = dict["x"] as! CGFloat * screenWidth
        let y: CGFloat = dict["y"] as! CGFloat * screenHeight
        let width: CGFloat = dict["width"] as! CGFloat * screenWidth
        let height: CGFloat = dict["height"] as! CGFloat * screenHeight
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func scaleDown(dict: NSDictionary) -> CGRect {
        let x: CGFloat = dict["x"] as! CGFloat * screenWidth * scaleDownRatio
        let y: CGFloat = dict["y"] as! CGFloat * screenHeight * scaleDownRatio
        let width: CGFloat = dict["width"] as! CGFloat * screenWidth * scaleDownRatio
        let height: CGFloat = dict["height"] as! CGFloat * screenHeight * scaleDownRatio
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    @IBAction func tapButton(sender:UIButton!) {
        
        for tmpApp in BMStoryboardDataManager.sharedInstance.applications {
            if let app = tmpApp as? BMApplication {
                if app.id == self.appID && nextViewControllerID <= app.viewControllers.count-1 {
                    let vc = app.viewControllers.objectAtIndex(nextViewControllerID)
                    navigationController?.pushViewController(vc as! UIViewController, animated: true)
                    nextViewControllerID++
                }
            }
        }
        
    }
    
    func bindAndAddSubview(subview: UIView) {
        let singleTap = UITapGestureRecognizer(target: self, action: "handleSingleTapElement:")
        subview.addGestureRecognizer(singleTap)
        subview.userInteractionEnabled = true
        
        let pan = UIPanGestureRecognizer(target: self, action: "handlePan:")
        subview.addGestureRecognizer(pan)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: "handlePinch:")
        subview.addGestureRecognizer(pinch)
        
        var tmpView = subview as! BMComponentProtocol
        tmpView.isNew = true
        subview.tag = tmpView.id
        
        self.view.addSubview(subview)
    }
    
    var lastScale: CGFloat = 1.0
    func handlePinch(sender: UIPinchGestureRecognizer) {
        if sender.numberOfTouches() == 2, let view = sender.view {
            if sender.state == .Began {
                lastScale = 1.0
            }
            
            let scale = 1.0 - (lastScale - sender.scale)
            view.layer.setAffineTransform(CGAffineTransformScale(view.layer.affineTransform(), scale, scale))
            lastScale = sender.scale
        }
    }
    
    func handlePan(sender: UIPanGestureRecognizer) {
        if let view = sender.view {
            switch sender.state {
            case .Began:
                print("began")
                break
            case .Changed:
                let offset: CGPoint = sender.translationInView(self.view)
                view.center = CGPoint(x: view.center.x + offset.x, y: view.center.y + offset.y)
                sender.setTranslation(CGPoint.zero, inView: self.view)
                print("changed")
                break
            case .Ended:
                print("ended")
                break
            default:
                break
            }
        }
    }
    
    func handleSingleTapElement(tapRecognizer: UITapGestureRecognizer) {
        let tag = tapRecognizer.view?.tag
        print(tag)
        
        NSNotificationCenter.defaultCenter().postNotificationName("BMEditComponentTapped", object:nil, userInfo: ["viewTappedTag": tag as! AnyObject])
        // Add a setting view....
    }
}

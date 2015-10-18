//
//  BMTemplateViewController.swift
//  BoilerMakeIII
//
//  Created by Yi Qin on 10/17/15.
//  Copyright © 2015 Yi Qin. All rights reserved.
//

import UIKit

class BMTemplateViewController: UIViewController, BMComponentProtocol {
    
    enum State {
        case Play
        case Edit
    }
    
    var type = BMComponentType.ViewController
    var dictionary: NSDictionary {
        let dict: NSMutableDictionary = NSMutableDictionary()
        for case let component as BMComponentProtocol in self.view.subviews {
            let compDict: NSDictionary = component.dictionary
            dict.setObject(compDict, forKey: String(compDict.objectForKey("id")!))
        }
        return NSDictionary(dictionary: dict)
    }
    
    var id: Int
    
    // Reconstructor.
    init(appID: Int, vcID: Int, dict: NSDictionary?, state: State = .Play) {
        self.id = vcID
        
        super.init(nibName: nil, bundle: nil)

        if let vcDict = dict {
            self.title = vcDict["title"] as? String
        } else {
            self.title = "ViewController-\(vcID)"
        }
        
        if let dict = BMStoryboardDataManager.sharedInstance.getComponentsData(appID, vcID: vcID) {
            for (_, comp) in dict {
                let compDict: NSDictionary = comp as! NSDictionary
                let frame = rectFromDict(compDict)
                
                switch compDict["type"] as! NSString {
                case BMComponentType.Label.rawValue:
                    let label = BMLabel(frame: frame, dict: compDict)
                    
                    if state == .Play {
                        
                    } else {
                        
                    }
                    
                    self.view.addSubview(label)
                    print(label.dictionary)
                    break
                case BMComponentType.Button.rawValue:
                    let button = BMButton(frame: frame, dict: compDict)
                    if state == .Play {
                        button.addTarget(self, action: "tapButton:", forControlEvents: .TouchUpInside)
                    } else {
                        
                    }
                    
                    self.view.addSubview(button)
                    print(button.dictionary)
                    break;
                case BMComponentType.ImageView.rawValue:
                    let imageView = BMImageView(frame: frame, dict: compDict)
                    self.view.addSubview(imageView)
                    
                    if state == .Play {
                        
                    } else {
                        
                    }
                    
                    break;
                default:
                    break
                }
            }
            
            print(self.dictionary)
            
        } else {
            print("WARNING: Couldn't create dictionary from UIData.plist! Default values will be used!")
        }
    }

    // New ViewController
    convenience init(appID: Int) {
        self.init(appID: appID, vcID: BMStoryboardDataManager.sharedInstance.getNextID(), dict: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Helper Functions
    
    func rectFromDict(dict: NSDictionary) -> CGRect {
        let x: CGFloat = dict["x"] as! CGFloat * screenWidth
        let y: CGFloat = dict["y"] as! CGFloat * screenHeight
        let width: CGFloat = dict["width"] as! CGFloat * screenWidth
        let height: CGFloat = dict["height"] as! CGFloat * screenHeight
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    @IBAction func tapButton(sender:UIButton!) {
        
        let vc = BMTemplateViewController(appID: 10, vcID: 9, dict: nil)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

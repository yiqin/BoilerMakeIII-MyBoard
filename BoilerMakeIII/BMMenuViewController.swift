//
//  BMMenuViewController.swift
//  BoilerMakeIII
//
//  Created by Yifan Xiao on 10/17/15.
//  Copyright © 2015 Yi Qin. All rights reserved.
//

import UIKit


class BMMenuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
@IBOutlet weak var menuCollectionView: UICollectionView!
    
    var collectionData: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        let path = NSBundle.mainBundle().pathForResource("iOSDevice", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        
        collectionData = dict!.objectForKey("iOSDevice") as! [String]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BMMainMenuCell", forIndexPath: indexPath) as! BMMenuCollectionViewCell
        
        cell.cellTextLabel.text = collectionData[indexPath.row]
        cell.cellImage.image = UIImage(named: "\(collectionData[indexPath.row]).png")
        
        cell.contentView.layer.cornerRadius = 12.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clearColor().CGColor
        cell.contentView.layer.masksToBounds = true
        
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5;
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
            }
        
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

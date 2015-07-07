//
//  ViewController.swift
//  TransitionApp
//
//  Created by WOO Yu Kit on 1/7/15.
//  Copyright (c) 2015 WOO Yu Kit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    var navBtn: UIButton = UIButton(frame: CGRectMake(0, 0, 40, 40))
    
    @IBOutlet var headerView: UIView!
    @IBOutlet var imageTopConstraint: NSLayoutConstraint!
    @IBOutlet var imageBottomConstraint: NSLayoutConstraint!
    @IBOutlet var navBarBg: UIVisualEffectView!
    
    let kHeaderHeight:CGFloat = 150.0
    let kNavHeaderHeight:CGFloat = 64.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navBtn.setImage(UIImage(named: "Image"), forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navBtn)
        navBtn.layer.cornerRadius = 20
        navBtn.clipsToBounds = true
        navBtn.addTarget(self, action: Selector("navBtnClick"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.delegate = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: tight navigation button click
    func navBtnClick(){
        self.performSegueWithIdentifier("DetailSegue", sender: nil)
    }
    
    // MARK: UINavigationControllerDelegate methods
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ShowImageTransition()
    }
    // MARK: UITableViewDelegate methods
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    // MARK: UIScrollViewDelegate methods
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let scrollOffsetY = kHeaderHeight - scrollView.contentOffset.y

        if scrollOffsetY >= kHeaderHeight + kNavHeaderHeight{
            imageTopConstraint.constant = kHeaderHeight - scrollOffsetY
            navBarBg.alpha = 0
        }
        else{
            var opacity = -(scrollOffsetY-kHeaderHeight-kNavHeaderHeight)/(kHeaderHeight) > 1 ? 1 : -(scrollOffsetY-kHeaderHeight-kNavHeaderHeight)/(kHeaderHeight)
            navBarBg.alpha = opacity
        }

    }

}


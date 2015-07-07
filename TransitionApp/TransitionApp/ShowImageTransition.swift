//
//  ShowImageTransition.swift
//  TransitionApp
//
//  Created by WOO Yu Kit on 1/7/15.
//  Copyright (c) 2015 WOO Yu Kit. All rights reserved.
//

import UIKit

class ShowImageTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ViewController
        var toViewCotnroller = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! DetailViewController
    
        let containerView:UIView = transitionContext.containerView()
        let duration = transitionDuration(transitionContext)
        containerView.addSubview(toViewCotnroller.view)
        //Add Animation Below
        let imageView = UIImageView(frame: containerView.convertRect(fromViewController.navBtn.frame, fromView: fromViewController.view))
        imageView.image = UIImage(named: "Image")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        containerView.addSubview(imageView)
        
        toViewCotnroller.view.frame = transitionContext.finalFrameForViewController(toViewCotnroller)
        toViewCotnroller.view.alpha = 0
        toViewCotnroller.imageView?.hidden = true
        
        fromViewController.navBtn.hidden = true
        
        UIView.animateWithDuration(duration, delay:0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options:UIViewAnimationOptions.CurveEaseOut, animations: {
            toViewCotnroller.view.alpha = 1.0
            var frame = containerView.convertRect(toViewCotnroller.imageView.frame, fromView: toViewCotnroller.view)
            imageView.frame = CGRectMake(0, (toViewCotnroller.view.bounds.height - toViewCotnroller.view.bounds.width)/2, toViewCotnroller.view.bounds.width, toViewCotnroller.view.bounds.width)
            imageView.layer.cornerRadius = 0
            }, completion: {
                (value: Bool) in
                toViewCotnroller.view.alpha = 1.0
                toViewCotnroller.imageView?.hidden = false
                imageView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
}

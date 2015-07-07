//
//  DismissImageTransition.swift
//  TransitionApp
//
//  Created by WOO Yu Kit on 2/7/15.
//  Copyright (c) 2015 WOO Yu Kit. All rights reserved.
//

import UIKit

class DismissImageTransition: NSObject,UIViewControllerAnimatedTransitioning {
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! DetailViewController
        var toViewCotnroller = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! ViewController
        
        let containerView:UIView = transitionContext.containerView()
        let duration = transitionDuration(transitionContext)
        containerView.addSubview(toViewCotnroller.view)
        //Add Animation Below
        let imageView = UIImageView(frame: containerView.convertRect(fromViewController.imageView.frame, fromView: fromViewController.view))
        imageView.image = UIImage(named: "Image")
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        containerView.addSubview(imageView)
        
        toViewCotnroller.view.frame = transitionContext.finalFrameForViewController(toViewCotnroller)
        toViewCotnroller.view.alpha = 0
        
        fromViewController.imageView.hidden = true
        
        UIView.animateWithDuration(duration, delay:0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options:UIViewAnimationOptions.CurveEaseIn, animations: {
            toViewCotnroller.view.alpha = 1.0
            var frame = containerView.convertRect(toViewCotnroller.navBtn.frame, fromView: toViewCotnroller.view)
            frame.origin.y += 20
            imageView.frame = frame
            imageView.layer.cornerRadius = frame.size.width/2
            }, completion: {
                (value: Bool) in
                toViewCotnroller.view.alpha = 1.0
                toViewCotnroller.navBtn.hidden = false
                imageView.removeFromSuperview()
                fromViewController.imageView!.hidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
}

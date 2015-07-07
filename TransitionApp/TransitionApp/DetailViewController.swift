//
//  DetailViewController.swift
//  TransitionApp
//
//  Created by WOO Yu Kit on 1/7/15.
//  Copyright (c) 2015 WOO Yu Kit. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet var imageView : UIImageView!
    
    var interactivePopTransition:UIPercentDrivenInteractiveTransition?

    override func viewDidLoad() {
        super.viewDidLoad()
        let popRecongizer = UIScreenEdgePanGestureRecognizer(target: self, action: Selector("handlePopRecognizer:"))
        popRecongizer.edges = UIRectEdge.Left
        self.view.addGestureRecognizer(popRecongizer)
        // Do any additional setup after loading the view.
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
    
    // MARK: Edge pan gesture handler methods
    func handlePopRecognizer(recognizer:UIScreenEdgePanGestureRecognizer){
        var progress = recognizer.translationInView(self.view).x / self.view.bounds.size.width
        progress = min(1.0, max(0, progress))
        if recognizer.state == UIGestureRecognizerState.Began{
            interactivePopTransition = UIPercentDrivenInteractiveTransition()
            self.navigationController?.popViewControllerAnimated(true)
        }
        else if recognizer.state == UIGestureRecognizerState.Changed{
            interactivePopTransition?.updateInteractiveTransition(progress)
        }
        else if recognizer.state == UIGestureRecognizerState.Ended || recognizer.state == UIGestureRecognizerState.Cancelled{
            if progress > 0.5{
                interactivePopTransition?.finishInteractiveTransition()
            }
            else{
                interactivePopTransition?.cancelInteractiveTransition()
            }
            interactivePopTransition = nil
        }
    }
    
    // MARK: UINavigationControllerDelegate methods
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissImageTransition()
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactivePopTransition
    }

}

//
//  Extentions.swift
//  BPT_WebVIew
//
//  Created by Basith on 01/04/20.
//  Copyright © 2020 Agaze. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func startAnActivityIndicator() -> UIActivityIndicatorView{
        let ai = UIActivityIndicatorView(style: .large)
        self.view.addSubview(ai)
        self.view.bringSubviewToFront(ai)
        ai.center = CGPoint(x: view.frame.width / 2, y: 180)
        ai.hidesWhenStopped = true
        ai.startAnimating()
        return ai
    }
    // this function will create a button with specfied parameters on superview.
    func addSwipeUpButton(labelTitle: String, labelColor: UIColor, backgroundColor: UIColor, frame: CGRect){
       let swipeButton = UIButton(frame: frame)
        swipeButton.setTitle(labelTitle, for: .normal)
        swipeButton.setTitleColor(labelColor, for: .normal)
        swipeButton.backgroundColor = backgroundColor
        swipeButton.contentHorizontalAlignment = .center
        swipeButton.sizeToFit()
        swipeButton.translatesAutoresizingMaskIntoConstraints = false
        swipeButton.center.x = self.view.center.x
        swipeButton.tag = 990
        self.view.addSubview(swipeButton)
//        self.view.bringSubviewToFront(swipeButton) 8736
       
        let centerVertically = NSLayoutConstraint(item: swipeButton,
                                                  attribute: .centerX,
                                                  relatedBy: .equal,
                                                  toItem: view,
                                                  attribute: .centerX,
                                                  multiplier: 1.0,
                                                  constant: 0.0)
        NSLayoutConstraint.activate([
            swipeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            centerVertically
        ])
        
    }
    
    @objc open func addGestureToSuperView(){
        // do
    }
    
    func addOverLayToView(overlayColor: UIColor, alpha: CGFloat, overLayFrame: CGRect){
        let overlayView = UIView(frame: overLayFrame)
        overlayView.tag = 989
        overlayView.backgroundColor = overlayColor
        overlayView.alpha = alpha
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        overlayView.addGestureRecognizer(swipeDown)
        self.view.addSubview(overlayView)
        self.view.bringSubviewToFront(overlayView)
        
    }
    @objc open func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
                let subviews = self.view.subviews
                for subview in subviews{
                    if subview.tag == 989{
                        subview.removeFromSuperview()
                    }
                }
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
}

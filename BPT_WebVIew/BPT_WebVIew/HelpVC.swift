//
//  HelpVC.swift
//  BPT_WebVIew
//
//  Created by Basith on 01/04/20.
//  Copyright © 2020 Agaze. All rights reserved.
//

import UIKit
import WebKit

class HelpVC: UIViewController, WKNavigationDelegate {
    
    var overlayAdded = false 
    var url : URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        addSwipeUpButton(labelTitle: "Swipe Up", labelColor: .blue, backgroundColor: .white, frame: CGRect(x: self.view.center.x, y: 0, width: 64, height: 32))
        addGestureToSuperView()
    }
    
    override func addGestureToSuperView() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
    }
    @objc override func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
                let subviews = self.view.subviews
                for subview in subviews{
                    if subview.tag == 989{
                        subview.removeFromSuperview()
                    }
                }
                overlayAdded = false
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
                if overlayAdded{
                    // do nothing
                }else{
                    self.addOverLayToView(overlayColor: .black, alpha: 0.6, overLayFrame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
//                    addWebView(htmlfile: "https://www.youtube.com/" , type: "url")
                    addWebView(htmlfile: "basith" , type: "file")
                    overlayAdded = true
                }
            default:
                break
            }
        }
    }
    func addWebView(htmlfile:String, type : String){
        if type == "url" {
            url = URL(string: htmlfile)
        }else if type == "file"{
            url = Bundle.main.url(forResource: htmlfile, withExtension: "html", subdirectory: "")!
        }else {
            url = URL(string: "https://www.google.com/")
        }
        let webView = WKWebView(frame: CGRect(x: 30, y: 60, width: self.view.frame.width-60, height: self.view.frame.height-120))
        self.view.addSubview(webView)
        let request = URLRequest(url: url!)
        webView.navigationDelegate = self
        webView.load(request)
        webView.tag = 989
        let closeImage = UIButton(frame:  CGRect(x: self.view.frame.width-45, y: 45, width: 30, height: 30))
        closeImage.setImage(UIImage(named: "close"), for: .normal)
        closeImage.tag = 989
        closeImage.addTarget(self, action: #selector(respondToTapGesture(_:)), for: .touchUpInside)
        self.view.addSubview(closeImage)
        self.view.bringSubviewToFront(closeImage)
    }
    
    
    @objc func respondToTapGesture(_ sender : Any){
        let subviews = self.view.subviews
        for subview in subviews{
            if subview.tag == 989{
                subview.removeFromSuperview()
            }
        }
        overlayAdded = false
        print("tap")
    }
}


//
//  ViewController.swift
//  PIctureCheck
//
//  Created by chdo on 15/8/27.
//  Copyright (c) 2015年 chdo. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController {



    override func viewDidLoad() {
        super.viewDidLoad()
//        webview.loadRequest(NSURLRequest(URL: NSURL(string: "http://www.ezy3d.net/pub/cmsService.showTask.do?taskId=65963249123a463695e925e61824c749")!))
//        let pich = PinchView(frame: CGRectMake(0, 100, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.width), target: self)
//        pich.backgroundColor = UIColor.yellowColor()
//        self.view.addSubview(pich)

//        let web = WKWebView(frame: self.view.frame)
//            web.loadRequest(NSURLRequest(URL: NSURL(string: "http://www.ezy3d.net/pub/cmsService.showTask.do?taskId=65963249123a463695e925e61824c749")!))
//        self.view.addSubview(web)
        
        let si = UISwipeGestureRecognizer(target: self, action: "swip:")
            si.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(si)
        let lef = UISwipeGestureRecognizer(target: self, action: "swip:")
            lef.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(lef)
        
    }

    func swip(ges:UISwipeGestureRecognizer){
        print(ges.direction)
    }
    
    func left(){
        print(123123)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }




}


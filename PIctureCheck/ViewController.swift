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
        let ima = UIImageView(image: UIImage(named: "testPic"))
        ima.contentMode = UIViewContentMode.ScaleAspectFit
        ima.frame = CGRectMake(50, 50, 350, 350)
        view.addSubview(ima)
        
        ima.check()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }

}


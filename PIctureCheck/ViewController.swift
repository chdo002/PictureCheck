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
        ima.contentMode = .scaleAspectFit
        ima.frame = CGRect(x: 50, y: 50, width: 350, height: 350)
        view.addSubview(ima)
        
        ima.check()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

}


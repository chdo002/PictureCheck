//
//  ViewController.swift
//  PIctureCheck
//
//  Created by chdo on 15/8/27.
//  Copyright (c) 2015年 chdo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var testImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        testImage.check()
    }




}


//
//  PinchView.swift
//  PIctureCheck
//
//  Created by chdo on 15/9/18.
//  Copyright © 2015年 chdo. All rights reserved.
//

import UIKit

class PinchView: UIView {
    
    var isPicnState = false
    var pan: UIPanGestureRecognizer!
    var pinch: UIPinchGestureRecognizer!
    var showImge: UIImageView
    
    init(frame: CGRect,target:AnyObject){
        
        showImge = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.width))
        showImge.image = UIImage(named: "testPic")
        showImge.contentMode = .scaleAspectFill
        showImge.clipsToBounds = true
        
        super.init(frame: frame)
        
        self.addSubview(showImge)
        pan = UIPanGestureRecognizer(target: self, action: #selector(pan(ges:)))
        self.addGestureRecognizer(pan)
        pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinch(ges:)))
        self.addGestureRecognizer(pinch)
        self.clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pan(ges: UIPanGestureRecognizer){
        if !isPicnState {
            print(ges.location(in: self))
        }else{
            showImge.frame.origin.x += ges.translation(in: self).x
            showImge.frame.origin.y += ges.translation(in: self).y
            ges.setTranslation(CGPoint(x: 0, y: 0), in: self)
            backToCenter(ges: ges)
        }

    }
    
    @objc func pinch(ges: UIPinchGestureRecognizer){
        
        isPicnState = true
        
        let oldFrame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        
        let largeFrame = CGRect(x: 0 - oldFrame.size.width, y: 0 - oldFrame.size.height, width: 3 * oldFrame.size.width, height: 3 * oldFrame.size.height)
        let newCenter = showImge.center
        if ges.state == .began || ges.state == .changed {
            print(ges.scale)
            showImge.transform = showImge.transform.scaledBy(x: ges.scale, y: ges.scale)
            ges.scale = 1

        } else {
            if showImge.frame.size.width < self.frame.size.width {
                UIView.animate(withDuration: 0.1, animations: { () -> Void in
                    self.showImge.frame = oldFrame
                    self.isPicnState = false
                })
            }
            if showImge.frame.size.width > 3 * self.frame.size.width {
                UIView.animate(withDuration: 0.1, animations: { () -> Void in
                    self.showImge.frame = largeFrame
                    self.showImge.center = newCenter
                })
            }
        }
    }
    
    func backToCenter(ges: UIGestureRecognizer){
        let image     = showImge // 被操控对象
        let blackView = image.superview   // 背景黑色View
        
        let size = self.frame
    
        if ges.state == .ended { // 手势结束时判断图片是否在view内
            
            if image.frame.origin.x <  size.width - image.frame.size.width {
                UIView.animate(withDuration: 0.3) {
                    image.frame.origin.x = size.width - image.frame.size.width
                }
            }
            
            if image.frame.origin.y <  size.width - image.frame.size.height {
                UIView.animate(withDuration: 0.3) {
                    image.frame.origin.y = size.width - image.frame.size.height
                }
            }
            
            
            if image.frame.origin.x > 2 {
                UIView.animate(withDuration: 0.3) {
                    image.frame.origin.x = 0
                }
            }
            
            if image.frame.origin.y > 2 {
                UIView.animate(withDuration: 0.3) {
                    image.frame.origin.y = 0
                }
            }
            
            if image.frame.size.width <= size.width {
                UIView.animate(withDuration: 0.3) {
                    image.center = blackView!.center
                }
            }
        }
    }
}

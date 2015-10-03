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
    var showImge: UIImageView!
    
    init(frame: CGRect,target:AnyObject){
        super.init(frame: frame)
        showImge = UIImageView(frame: CGRectMake(0, 0, frame.width, frame.width))
        showImge.image = UIImage(named: "testPic")
        showImge.contentMode = UIViewContentMode.ScaleAspectFill
        showImge.clipsToBounds = true
        self.addSubview(showImge)
        pan = UIPanGestureRecognizer(target: self, action: "pan:")
        self.addGestureRecognizer(pan)
        pinch = UIPinchGestureRecognizer(target: self, action: "pinch:")
        self.addGestureRecognizer(pinch)
        self.clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pan(ges: UIPanGestureRecognizer){
        if !isPicnState {
            print(ges.locationInView(self))
        }else{
            showImge.frame.origin.x += ges.translationInView(self).x
            showImge.frame.origin.y += ges.translationInView(self).y
            ges.setTranslation(CGPointMake(0, 0), inView: self)
            backToCenter(ges)
        }

    }
    
    func pinch(ges: UIPinchGestureRecognizer){
        
        isPicnState = true
        
        let oldFrame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        
        let largeFrame = CGRectMake(0 - oldFrame.size.width, 0 - oldFrame.size.height, 3 * oldFrame.size.width, 3 * oldFrame.size.height)
        let newCenter = showImge.center
        if ges.state == UIGestureRecognizerState.Began || ges.state == UIGestureRecognizerState.Changed {
            print(ges.scale)
            showImge.transform = CGAffineTransformScale(showImge.transform, ges.scale, ges.scale)
            ges.scale = 1

        }else{
            if showImge.frame.size.width < self.frame.size.width {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.showImge.frame = oldFrame
                    self.isPicnState = false
                })
            }
            if showImge.frame.size.width > 3 * self.frame.size.width {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.showImge.frame = largeFrame
                    self.showImge.center = newCenter
                })
            }
        }
    }
    
    func backToCenter(ges: UIGestureRecognizer){
        let image     = showImge // 被操控对象
        let blackView = image.superview!   // 背景黑色View
        
        let size = self.frame
    
        if ges.state == UIGestureRecognizerState.Ended { // 手势结束时判断图片是否在view内
            
            if image.frame.origin.x <  size.width - image.frame.size.width {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    image.frame.origin.x = size.width - image.frame.size.width
                })
            }
            
            if image.frame.origin.y <  size.width - image.frame.size.height {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    image.frame.origin.y = size.width - image.frame.size.height
                })
            }
            
            
            if image.frame.origin.x > 2 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    image.frame.origin.x = 0
                })
            }
            
            if image.frame.origin.y > 2 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    image.frame.origin.y = 0
                })
            }
            
            if image.frame.size.width <= size.width {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    image.center = blackView.center
                })
            }
        }
    }
}

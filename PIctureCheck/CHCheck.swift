
import UIKit

extension UIImageView {
    
    /**
    trick tap to check
    */
    func check(){
        self.userInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tap"))
    }
    
    func tap(){
        // origin picture frame

        let originFrame = UIApplication.sharedApplication().keyWindow?.convertRect(frame, fromView: superview)
        // add blackbackground
        let black = UIView(frame: UIScreen.mainScreen().bounds)
            black.backgroundColor = UIColor.blackColor()
            black.alpha = 0
        UIApplication.sharedApplication().keyWindow?.addSubview(black)
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            black.alpha = 1
        })
        
        //new image to show
        let touchB = UIView(frame: UIScreen.mainScreen().bounds)
            touchB.backgroundColor = UIColor.greenColor()
        let image = UIImageView()
            image.frame =  originFrame!
            image.image = self.image
            image.contentMode = UIViewContentMode.ScaleAspectFit
            touchB.addSubview(image)
        
        black.addSubview(touchB)

        UIView.animateWithDuration(0.3, animations: { () -> Void in
            image.frame = UIScreen.mainScreen().bounds
        })


        touchB.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "remove:"))
        touchB.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "pan:"))
        touchB.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: "pinch:"))

    }
    
    func remove(ges:UIGestureRecognizer){
        
        let imaView = ges.view!.subviews[0]             // NewImage
        let gesView = ges.view!.superview               // black
        let originFrame = UIApplication.sharedApplication().keyWindow?.convertRect(frame, fromView: superview)
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            imaView.frame = originFrame!
        }) { (_) -> Void in
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                gesView!.alpha = 0
            }, completion: { (_) -> Void in
                gesView!.removeFromSuperview()
            })
        }
    }
    
    func pan(ges : UIPanGestureRecognizer){
        let image     = ges.view! // 被操控对象
        let blackView = image.superview!          // 背景黑色View
        
        let size = UIScreen.mainScreen().bounds
        
        image.frame.origin.x += ges.translationInView(blackView).x
        image.frame.origin.y += ges.translationInView(blackView).y
        ges.setTranslation(CGPointMake(0, 0), inView: blackView)
        
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

    func pinch(ges : UIPinchGestureRecognizer){

        let vie = ges.view!

        let oldFrame = UIApplication.sharedApplication().keyWindow!.frame
//        let largeFrame = CGRectMake(0 - oldFrame.size.width, 0 - oldFrame.size.height, 3 * oldFrame.size.width, 3 * oldFrame.size.height)
//        let newCenter = vie.center
        if ges.state == UIGestureRecognizerState.Began || ges.state == UIGestureRecognizerState.Changed {
            vie.transform = CGAffineTransformScale(vie.transform, ges.scale, ges.scale)
            ges.scale = 1
        }else{
            if vie.frame.size.width < oldFrame.size.width {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    vie.frame = oldFrame
                    vie.subviews[0].frame = oldFrame
                    vie.subviews[0].transform = CGAffineTransformScale(vie.subviews[0].transform, 1, 1)
                })
            }
//            else if vie.frame.size.width > 3 * oldFrame.size.width {
//                UIView.animateWithDuration(0.1, animations: { () -> Void in
//                    vie.frame = largeFrame
//                    vie.center = newCenter
//                })
//            }else{
//                let x = vie.frame.origin.x
//                let y = vie.frame.origin.y
//                
//                let xRU = oldFrame.width - (vie.frame.origin.x + vie.frame.width)
//                let yRU = vie.frame.origin.y
//                
//                let xRD = oldFrame.width - (vie.frame.origin.x + vie.frame.width)
//                let yRD = oldFrame.height - (vie.frame.origin.y + vie.frame.height)
//                
//                let xLD = vie.frame.origin.x
//                let yLD = oldFrame.height - (vie.frame.origin.y + vie.frame.height)
//                
//                var oldF = vie.frame
//
//                if x > 0 && y > 0 {                 // 右下
//                    oldF.origin = CGPointMake(0, 0)
//                }else if xRU > 0 && yRU > 0 {       // 左下
//                    let newX = oldFrame.width - oldF.width
//                    oldF.origin = CGPointMake(newX, 0)
//                }else if xLD > 0 && yLD > 0 {       // 右上
//                    let newY = oldFrame.height - oldF.height
//                    oldF.origin = CGPointMake(0, newY)
//                }else if xRD > 0 && yRD > 0 {       // 左上
//                    let newX = oldFrame.width - oldF.width
//                    let newY = oldFrame.height - oldF.height
//                    oldF.origin = CGPointMake(newX, newY)
//                }
//                UIView.animateWithDuration(0.1, animations: { () -> Void in
//                    vie.frame = oldF
//                })
//                
//            }
        }
        
    }
}

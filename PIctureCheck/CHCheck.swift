
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
        var originSize = self.image!.size
        let newWidth  = UIScreen.mainScreen().bounds.width
        let newHeight = (UIScreen.mainScreen().bounds.width / originSize.width) * originSize.height
        let originFrame = CGRectMake((UIScreen.mainScreen().bounds.width - self.frame.width) / 2, (UIScreen.mainScreen().bounds.height / 2 - self.frame.height / 2 ), self.frame.size.width, self.frame.size.height)
        // add blackbackground
        var black = UIView(frame: UIScreen.mainScreen().bounds)
            black.backgroundColor = UIColor.blackColor()
            black.alpha = 0
        UIApplication.sharedApplication().keyWindow?.addSubview(black)
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            black.alpha = 1
        })
        
        //new image to show
        var image = UIImageView()
            image.frame = originFrame
            image.image = self.image
            image.contentMode = UIViewContentMode.ScaleAspectFit
            image.userInteractionEnabled = true
        
        black.addSubview(image)

        UIView.animateWithDuration(0.3, animations: { () -> Void in
            image.frame = CGRectMake(0, (UIScreen.mainScreen().bounds.height / 2 - newHeight / 2 ), newWidth, newHeight)
        })


        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "remove:"))
        image.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "pan:"))
        image.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: "pinch:"))

    }
    
    func remove(ges:UIGestureRecognizer){
        
        var gesView = ges.view as! UIImageView
        
        var superView = gesView.superview
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            var fra = CGRectMake(self.frame.origin.x, self.frame.origin.y , self.frame.size.width, self.frame.size.height)
            gesView.frame = fra
        }) { (_) -> Void in
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                superView!.alpha = 0
            }, completion: { (_) -> Void in
                superView!.removeFromSuperview()
            })
        }
    }
    
    func pan(ges : UIPanGestureRecognizer){
        var image     = ges.view as! UIImageView // 被操控对象
        var blackView = image.superview!          // 背景黑色View
        
        var size = UIScreen.mainScreen().bounds
        
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
        //get imageview
        var vie = ges.view
        // standerd sclae
        var oldFrame = UIApplication.sharedApplication().keyWindow?.frame
        // origin picture frame
        var originSize = self.image!.size
        let newWidth  = UIScreen.mainScreen().bounds.width
        let newHeight = (UIScreen.mainScreen().bounds.width / originSize.width) * originSize.height
        let originFrame = CGRectMake((UIScreen.mainScreen().bounds.width - self.frame.width) / 2, (UIScreen.mainScreen().bounds.height / 2 - self.frame.height / 2 ), self.frame.size.width, self.frame.size.height)
        // largest scale
        var largeFrame = CGRectMake(0 - oldFrame!.size.width, 0 - oldFrame!.size.height, 3 * oldFrame!.size.width, 3 * oldFrame!.size.height)
        if ges.state == UIGestureRecognizerState.Began || ges.state == UIGestureRecognizerState.Changed {
            vie?.transform = CGAffineTransformScale(vie!.transform, ges.scale, ges.scale)
            ges.scale = 1
        }else{
            if vie!.frame.size.width < originFrame.size.width {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    vie!.frame = originFrame
                })
                
            }
            if vie!.frame.size.width > 3 * originFrame.size.width {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    vie!.frame.size = largeFrame.size
                })
                
            }
        }
    }
}

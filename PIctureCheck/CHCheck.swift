
import UIKit

extension UIImageView {
    
    /**
     trick tap to check
     */
    func check(){
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
    
    @objc func tap(){
        // origin picture frame
        
        let originFrame = UIApplication.shared.keyWindow?.convert(frame, from: superview)
        // add blackbackground
        let black = UIView(frame: UIScreen.main.bounds)
        black.backgroundColor = UIColor.black
        black.alpha = 0
        UIApplication.shared.keyWindow?.addSubview(black)
        UIView.animate(withDuration: 0.3) {
            black.alpha = 1
        }
        
        //new image to show
        let touchB = UIView(frame: UIScreen.main.bounds)
        touchB.backgroundColor = UIColor.green
        let image = UIImageView()
        image.frame =  originFrame!
        image.image = self.image
        image.contentMode = .scaleAspectFit
        touchB.addSubview(image)
        
        black.addSubview(touchB)
        
        UIView.animate(withDuration: 0.3) {
            image.frame = UIScreen.main.bounds
        }
        
        touchB.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(remove(ges:))))
        touchB.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(pan(ges:))))
        touchB.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(pinch(ges:))))
        
    }
    
    @objc func remove(ges:UIGestureRecognizer){
        
        let imaView = ges.view!.subviews[0]             // NewImage
        let gesView = ges.view!.superview               // black
        let originFrame = UIApplication.shared.keyWindow?.convert(frame, from: superview)
        UIView.animate(withDuration: 0.3) {
            imaView.frame = originFrame!
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                gesView!.alpha = 0
            } completion: { _ in
                gesView!.removeFromSuperview()
            }
        }
    }
    
    @objc func pan(ges : UIPanGestureRecognizer){
        let image     = ges.view! // 被操控对象
        let blackView = image.superview!          // 背景黑色View
        
        let size = UIScreen.main.bounds
        
        image.frame.origin.x += ges.translation(in: blackView).x
        image.frame.origin.y += ges.translation(in: blackView).y
        ges.setTranslation(CGPoint(x: 0, y: 0), in: blackView)
        
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
                    image.center = blackView.center
                }
            }
        }
    }
    
    @objc func pinch(ges : UIPinchGestureRecognizer){
        
        let vie = ges.view!
        
        let oldFrame = UIApplication.shared.keyWindow!.frame
        //        let largeFrame = CGRectMake(0 - oldFrame.size.width, 0 - oldFrame.size.height, 3 * oldFrame.size.width, 3 * oldFrame.size.height)
        //        let newCenter = vie.center
        if ges.state == .began || ges.state == .changed {
            vie.transform = vie.transform.scaledBy(x: ges.scale, y: ges.scale)
            ges.scale = 1
        }else{
            if vie.frame.size.width < oldFrame.size.width {
                UIView.animate(withDuration: 0.3) {
                    vie.frame = oldFrame
                    vie.subviews[0].frame = oldFrame
                    vie.subviews[0].transform = vie.subviews[0].transform.scaledBy(x: 1, y: 1)
                }
            }
        }
        
    }
}

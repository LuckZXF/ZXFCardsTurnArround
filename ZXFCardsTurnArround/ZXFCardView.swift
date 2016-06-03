//
//  File.swift
//  ZXFCardsTurnArround
//
//  Created by 赵希帆 on 16/6/1.
//  Copyright © 2016年 赵希帆. All rights reserved.
//

import UIKit


class ZXFCardView: UIImageView {
    
    var beginPoint : CGPoint!           //滑动起点
    var Center : CGPoint?               //初始视图中点
    var PI_Size : CGFloat?              //旋转角度
    var PI_Height : CGFloat = 0.0       //刷动高度轨迹
    var delegate : CardCountDelegate?   //翻滚图片代理
    
    func initCardImage(image : UIImage,center : CGPoint) -> Void {
        self.image = image
        self.backgroundColor = UIColor.clearColor()
        Center = center
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch : UITouch! =  touches.first as UITouch!
        beginPoint = touch!.locationInView(self)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch : UITouch! =  touches.first as UITouch!
        let nowPoint : CGPoint = touch!.locationInView(self)
        let offsetX = nowPoint.x - beginPoint.x
        let offsetY = nowPoint.y - beginPoint.y
        
        //修改下面的数字100可以改变卡片的滑动轨迹
        if offsetX > 0 && self.center.x >= Center?.x {
            PI_Height = (1-((Gloab.Screen_Width! - self.center.x)*2 / Gloab.Screen_Width!)) * 100 + Center!.y
            if (PI_Height > 100 || PI_Height < -100) {
                self.center = CGPointMake(self.center.x + offsetX,  PI_Height)
            }
            
        }
        else if offsetX < 0 && self.center.x <= Center?.x {
            PI_Height = ((Gloab.Screen_Width!/2 - self.center.x)*2 / Gloab.Screen_Width!) * 100 + Center!.y
            if (PI_Height > 100 || PI_Height < -100) {
                self.center = CGPointMake(self.center.x + offsetX,  PI_Height)
            }
//            self.center = CGPointMake(self.center.x + offsetX,  PI_Height)
        }
        else if offsetX < 0 && self.center.x >= Center?.x {
            PI_Height = (1-((Gloab.Screen_Width! - self.center.x)*2 / Gloab.Screen_Width!)) * 100 + Center!.y
            if (PI_Height > 100 || PI_Height < -100) {
                self.center = CGPointMake(self.center.x + offsetX,  PI_Height)
            }
//            self.center = CGPointMake(self.center.x + offsetX,  PI_Height)
        }
        else if offsetX > 0 && self.center.x <= Center?.x {
            PI_Height = ((Gloab.Screen_Width!/2 - self.center.x)*2 / Gloab.Screen_Width!) * 100 + Center!.y
            if (PI_Height > 100 || PI_Height < -100) {
                self.center = CGPointMake(self.center.x + offsetX,  PI_Height)
            }
//            self.center = CGPointMake(self.center.x + offsetX,  PI_Height)
        }

        self.turnArround(offsetX, distanceY : offsetY)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
        if self.center.x > 4 * Gloab.Screen_Width! / 5 {
            self.hidden = true
            delegate?.CardCountReduce(self)
        }
        else if self.center.x < Gloab.Screen_Width! / 5{
            self.hidden = true
            delegate?.CardCountReduce(self)
        }
        self.center = CGPointMake(Center!.x, Center!.y)
        var transform : CGAffineTransform = CGAffineTransformMakeRotation((CGFloat)(M_PI/180.0))
        self.transform = transform
    }
    
    func turnArround(distanceX:CGFloat,distanceY:CGFloat) -> Void {

        //旋转的角度计算
//        if distanceX > 0 && self.center.x >= Center?.x {
//            PI_Size = (1-((Gloab.Screen_Width! - self.center.x)*2 / Gloab.Screen_Width!)) * 90.0
//        }
//        else if distanceX < 0 && self.center.x <= Center?.x{
//            PI_Size = ((Gloab.Screen_Width!/2 - self.center.x)*2 / Gloab.Screen_Width!) * -90
//        }
//        else if distanceX < 0 && self.center.x >= Center?.x{
//            PI_Size = (1-((Gloab.Screen_Width! - self.center.x)*2 / Gloab.Screen_Width!)) * 90.0
//        }
//        else if distanceX > 0 && self.center.x <= Center?.x{
//            PI_Size = ((Gloab.Screen_Width!/2 - self.center.x)*2 / Gloab.Screen_Width!) * -90
//        }
        PI_Size = (1-((Gloab.Screen_Width! - self.center.x)*2 / Gloab.Screen_Width!)) * 90.0
//        PI_Size = ((Gloab.Screen_Width!/2 - self.center.x)*2 / Gloab.Screen_Width!) * -90

        var transform : CGAffineTransform = CGAffineTransformMakeRotation((CGFloat)(PI_Size! * CGFloat(Float(M_PI)/180.0)))
        self.transform = transform
        
    }
    
    
    
}

//
//  RatingBar.swift
//  Lives_ios
//
//  Created by lk on 15/8/26.
//  Copyright (c) 2015年 kelvin. All rights reserved.
//

import UIKit

class RatingBar: UIView {
    
    var _starSize : CGFloat!       /* 根据字体大小来确定星星的大小 */
    var _maxStar : CGFloat!      /* 总共的长度 */
    var _showStar : CGFloat!   //需要显示的星星的长度
    var _emptyColor : UIColor!  //未点亮时候的颜色
    var _fullColor : UIColor!    //点亮的星星的颜色
    
    var _suffixText : NSString! = ""
    
    let startNumber = 5
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        
        let stars : NSString = "★★★★★"
        
        var rect = self.bounds
        let font = UIFont.boldSystemFontOfSize(_starSize)
        let starSize = stars.sizeWithAttributes([NSFontAttributeName : font])
        rect.size=starSize;
        stars.drawInRect(rect, withAttributes: [NSFontAttributeName : font,NSForegroundColorAttributeName : _emptyColor])
        
        var clip = rect
        clip.size.width = (clip.size.width * CGFloat(_showStar)) / CGFloat(_maxStar)
        CGContextClipToRect(context,clip);
        stars.drawInRect(rect, withAttributes: [NSFontAttributeName : font,NSForegroundColorAttributeName : _fullColor])
        
        let suffixText = _suffixText
        if suffixText != "" {
            let textFont = UIFont.systemFontOfSize(_starSize)
            let textSize = _suffixText.sizeWithAttributes([NSFontAttributeName : font])
            rect.size = textSize
            rect.origin.x += starSize.width
            suffixText.drawInRect(rect, withAttributes: [NSFontAttributeName : font,NSForegroundColorAttributeName : _emptyColor])
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        self._emptyColor = UIColor.whiteColor()
        self._fullColor = UIColor(red: 1, green: 121.0 / 255, blue: 22.0 / 255, alpha: 1)
        self._maxStar = CGFloat(startNumber)
        self._showStar = 2
        self._starSize = frame.width / _maxStar
        
    }
    init(starSize : CGFloat) {
        super.init(frame: CGRectMake(0, 0, starSize * CGFloat(startNumber), starSize))
        
        self.backgroundColor = UIColor.clearColor()
        self._emptyColor = UIColor.whiteColor()
        self._fullColor = UIColor(red: 1, green: 121.0 / 255, blue: 22.0 / 255, alpha: 1)
        self._maxStar = CGFloat(startNumber)
        self._showStar = 0
        self._starSize = starSize
    }
    convenience init(frame : CGRect, clickable : Bool){
        self.init(frame: frame)
        self.userInteractionEnabled = clickable
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        println(touches.count)
        for t  in touches {
            let tt = t as! UITouch
            if tt.phase == UITouchPhase.Ended {
                let p = tt.previousLocationInView(self)
                let starNumber = Int(p.x * _maxStar) / Int(frame.width) + 1
                
                _showStar = CGFloat(starNumber)
                self.setNeedsDisplay()
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

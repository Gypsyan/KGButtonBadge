//
//  KGButtonBadge.swift
//  KGButtonBadge
//
//  Created by Anantha Krishnan K G on 29/11/16.
//  Copyright © 2016 Ananth. All rights reserved.
//

import UIKit

@IBDesignable
open class KGButtonBadge: UIButton {
    
    fileprivate var badgeIcon: UILabel
    fileprivate var badgeEdgeInsets: UIEdgeInsets?
    
    @IBInspectable
    open var badgeValue: String = "0" {
        didSet {
            setupBadgeViewWithString(badgeText: badgeValue)
        }
    }
    
    @IBInspectable
    open var makeRound:Bool = false {
        didSet {
            setupBadgeViewWithString(badgeText: badgeValue)
        }
    }
    
    @IBInspectable
    open var badgeBackgroundColor:UIColor = UIColor.blue {
        didSet {
            badgeIcon.backgroundColor = badgeBackgroundColor
        }
    }
    
    @IBInspectable
    open var badgeTextColor:UIColor = UIColor.white {
        didSet {
            badgeIcon.textColor = badgeTextColor
        }
    }
    
    override public init(frame: CGRect) {
        badgeIcon = UILabel()
        super.init(frame: frame)
        // Initialization code
        setupBadgeViewWithString(badgeText: "")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        badgeIcon = UILabel()
        super.init(coder: aDecoder)
        setupBadgeViewWithString(badgeText: "")
    }
    
    open func initWithFrame(frame: CGRect, withBadgeString badgeString: String, withBadgeInsets badgeInsets: UIEdgeInsets) -> AnyObject {
        
        badgeIcon = UILabel()
        badgeEdgeInsets = badgeInsets
        setupBadgeViewWithString(badgeText: badgeString)
        return self
    }
    
    fileprivate func setupBadgeViewWithString(badgeText: String?) {
        badgeIcon.clipsToBounds = true
        badgeIcon.text = badgeText
        badgeIcon.font = UIFont.systemFont(ofSize: 12)
        badgeIcon.textAlignment = .center
        badgeIcon.sizeToFit()
        let badgeSize = badgeIcon.frame.size
        
        let height = max(20, Double(badgeSize.height) + 5.0)
        let width = max(height, Double(badgeSize.width) + 10.0)
        
        var vertical: Double?, horizontal: Double?
        if let badgeInset = self.badgeEdgeInsets {
            vertical = Double(badgeInset.top) - Double(badgeInset.bottom)
            horizontal = Double(badgeInset.left) - Double(badgeInset.right)
            
            let x = (Double(bounds.size.width) - 10 + horizontal!)-20
            let y = -(Double(badgeSize.height) / 2) - 10 + vertical!
            badgeIcon.frame = CGRect(x: x, y: y, width: width, height: height)
        } else {
            let x = self.frame.width - CGFloat((width / 2.0))
            let y = CGFloat(-(height / 2.0))
            badgeIcon.frame = CGRect(x: x, y: y, width: CGFloat(width), height: CGFloat(height))
        }
        
        setupBadgeStyle()
        addSubview(badgeIcon)
        
        if let text = badgeText {
            badgeIcon.isHidden = text != "" ? false : true
        } else {
            badgeIcon.isHidden = true
        }
    }
    
    fileprivate func setupBadgeStyle() {
        badgeIcon.textAlignment = .center
        badgeIcon.backgroundColor = badgeBackgroundColor
        badgeIcon.textColor = badgeTextColor
        badgeIcon.layer.cornerRadius = badgeIcon.bounds.size.height / 2
        if self.bounds.size.height > self.bounds.size.width {
            self.layer.cornerRadius = self.bounds.size.height/2
        } else{
            self.layer.cornerRadius = self.bounds.size.width/2
        }
    }
}

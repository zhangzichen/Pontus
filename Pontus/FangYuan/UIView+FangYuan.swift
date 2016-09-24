

import Foundation
import UIKit

private var X: Int8 = 0
private var Y: Int8 = 0

// MARK: - Chainable getter
public extension UIView {
    var chainLeft : CGFloat {
        if hasNoSuperView {
            return 0
        }
        return superview!.width - left
    }
    
    var chainRight: CGFloat {
        return left + width
    }
    
    var chainBottom: CGFloat {
        return top + height
    }
    
    var chainTop : CGFloat {
        if hasNoSuperView {
            return 0
        }
        return superview!.height - top
    }
}

public extension UIView {
    
    fileprivate var fangYuanX: FangYuan {
        if objc_getAssociatedObject(self, &X) == nil {
            objc_setAssociatedObject(self, &X, FangYuan(), .OBJC_ASSOCIATION_RETAIN)
        }
        return objc_getAssociatedObject(self, &X) as! FangYuan
    }
    fileprivate var fangYuanY: FangYuan {
        if objc_getAssociatedObject(self, &Y) == nil {
            objc_setAssociatedObject(self, &Y, FangYuan(), .OBJC_ASSOCIATION_RETAIN)
        }
        return objc_getAssociatedObject(self, &Y) as! FangYuan
    }
    
    func left(_ left:CGFloat) -> Self {
        self.left = left
        return self
    }
    
    func right(_ right:CGFloat) -> Self {
        self.right = right
        return self
    }
    
    func top(_ top:CGFloat) -> Self {
        self.top = top
        return self
    }
    
    func bottom(_ bottom:CGFloat) -> Self {
        self.bottom = bottom
        return self
    }
    
    func height(_ height:CGFloat) -> Self {
        self.height = height
        return self
    }
    
    func width(_ width:CGFloat) -> Self {
        self.width = width
        return self
    }
    
    func size(_ size:CGSize) -> Self {
        self.size = size
        return self
    }
    
    func size(width: CGFloat, height:CGFloat) -> Self {
        return self.size(CGSize(width: width, height: height))
    }
    
    func origin(_ origin:CGPoint) -> Self {
        self.origin = origin
        return self
    }
    
    func origin(x:CGFloat, y:CGFloat) -> Self {
        return self.origin(CGPoint(x: x, y: y))
    }
    
    func center(_ center:CGPoint) -> Self {
        self.center = center
        return self
    }
    
    func edge(_ edge:UIEdgeInsets) -> Self {
        top = edge.top
        bottom = edge.bottom
        left = edge.left
        right = edge.right
        return self
    }
    
    fileprivate var hasNoSuperView : Bool {
        let noSuperView = superview == nil
        if  noSuperView {
            tellHasNoSuperView()
        }
        return noSuperView
    }
    
    fileprivate func tellHasNoSuperView() {
        print("⚠️FangYuan: You must set superView before use FangYuan!")
    }
    
    fileprivate(set) var left: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
            if hasNoSuperView {
                return
            }
            fangYuanX.x = newValue
            if fangYuanX.z != nil {
                frame.size.width = superview!.width - left - fangYuanX.z!
            }
        }
    }
    
    fileprivate(set) var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
            if hasNoSuperView {
                return
            }
            fangYuanX.y = newValue
            if fangYuanX.z != nil {
                frame.origin.x = superview!.width - width - fangYuanX.z!
            }
        }
    }
    
    fileprivate(set) var right: CGFloat {
        get {
            if hasNoSuperView {
                return 0
            }
            return superview!.width - chainRight
        }
        set {
            if hasNoSuperView {
                return
            }
            fangYuanX.z = newValue
            if fangYuanX.x != nil {
                frame.size.width = superview!.width - left - fangYuanX.z!
            } else {
                frame.origin.x = superview!.width - width - fangYuanX.z!
            }
        }
    }
    
    fileprivate(set) var top: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
            if hasNoSuperView {
                return
            }
            fangYuanY.x = newValue
            if fangYuanY.z != nil {
                frame.size.height = superview!.height - top - fangYuanY.z!
            }
        }
    }
    
    fileprivate(set) var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
            if hasNoSuperView {
                return
            }
            fangYuanY.y = newValue
            if fangYuanY.z != nil {
                frame.origin.y = superview!.height - height - fangYuanY.z!
            }
        }
    }
    
    fileprivate(set) var bottom: CGFloat {
        get {
            if hasNoSuperView {
                return 0
            }
            return superview!.height - chainBottom
        }
        set {
            if hasNoSuperView {
                return
            }
            fangYuanY.z = newValue
            if fangYuanY.x != nil {
                frame.size.height = superview!.height - top - fangYuanY.z!
            } else {
                frame.origin.y = superview!.height - height - fangYuanY.z!
            }
        }
    }
    
    fileprivate(set) var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
            left = newValue.x
            top = newValue.y
        }
    }
    
    fileprivate(set) var size: CGSize {
        get {
            return frame.size
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }
    
    fileprivate(set) var reOrigin: CGPoint {
        get {
            return CGPoint(x: right, y: bottom)
        }
        set {
            right = newValue.x
            bottom = newValue.y
        }
    }
    
    
}


import UIKit

//  Such code will make compiler crazy!!!
//  let height = ((ScreenHeight - 64 - 44 - WCKeyboardObserver.currentKeyboardHeight) / 55) * 55.f


/**
 *  对 Int/Float/Double 的一个拓展，方便将数据展现在视图上
 */
public protocol CGFloatable {
    /// 一个 CGFloat 值
    var f : CGFloat { get }
}

extension CGFloat : CGFloatable {
    public var f : CGFloat {
        return self
    }
}

extension Double : CGFloatable {
    public var f : CGFloat {
        return CGFloat(self)
    }
}

extension Float : CGFloatable {
    public var f : CGFloat {
        return CGFloat(self)
    }
}

extension Int : CGFloatable {
    public var f : CGFloat {
        return CGFloat(self)
    }
}

public extension CGSize {
    init(width:CGFloatable, height:CGFloatable) {
        self.width = width.f
        self.height = height.f
    }
}

public extension CGPoint {
    init(x:CGFloatable, y: CGFloatable) {
        self.x = x.f
        self.y = y.f
    }
}

public extension CGRect {
    init(x: CGFloatable, y: CGFloatable, width: CGFloatable, height: CGFloatable) {
        self.origin = CGPoint(x: x, y: y)
        self.size = CGSize(width: width, height: height)
    }
}

public func *(lhs: CGFloatable, rhs: CGFloatable) -> CGFloat {
    return lhs.f * rhs.f
}

public func -(lhs: CGFloatable, rhs: CGFloatable) -> CGFloat {
    return lhs.f - rhs.f
}

public func +(lhs: CGFloatable, rhs: CGFloatable) -> CGFloat {
    return lhs.f + rhs.f
}

public func /(lhs: CGFloatable, rhs: CGFloatable) -> CGFloat {
    return lhs.f / rhs.f
}

/**
 根据屏幕宽度选择不同的值进行适配，针对其他尺寸默认返回 _375
 
 - parameter _320: 4s/5/5s
 - parameter _375: 6/6s
 - parameter _414: 6p/6sp
 
 */
public func ValueWithScreenWidth_320(_ _320 : CGFloatable, _375 : CGFloatable, _414 : CGFloatable) -> CGFloat {
    switch ScreenWidth {
    case 414.f:
        return _414.f
    case 320.f:
        return _320.f
    default:
        return _375.f
    }
}

/**
 根据屏幕高度分别选择不同的值进行适配，针对其他尺寸默认返回 _667
 
 - parameter _480: 4s
 - parameter _568: 5/5s
 - parameter _667: 6/6s
 - parameter _736: 6p/6sp
 
 */
public func ValueWithScreenHeight_480(_ _480 : CGFloatable, _568: CGFloatable, _667: CGFloatable, _736: CGFloatable) -> CGFloat {
    switch ScreenHeight {
    case 480.f:
        return _480.f
    case 568.f:
        return _568.f
    case 736.f:
        return _736.f
    default:
        return _667.f
    }
}

public extension CGFloatable {
    
    /// 返回一个宽和高都为自己的值
    public var size : CGSize {
        return CGSize(width: f, height: f)
    }
    
    /// 返回一个宽和高都为自己的值
    public var square : CGSize {
        return size
    }
    /// 返回一个x和y都为自己的值
    public var origin : CGPoint {
        return CGPoint(x: f, y: f)
    }
    
    /// 很多时候需要设置 ×2 的属性
    public var double : CGFloat {
        return self * 2
    }
}

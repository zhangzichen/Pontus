

import UIKit

internal class FangYuan {
    
    enum ConstraintDimension {
        case x
        case y
        case z
    }
    
    var last : ConstraintDimension?
    
    var x : CGFloat? {
        didSet {
            guard x != nil else {
                return
            }
            if let last = last {
                if last == .y {
                    z = nil
                } else if last == .z {
                    y = nil
                }
            }
            last = .x
        }
    }
    
    var y : CGFloat? {
        didSet {
            guard y != nil else {
                return
            }
            if let last = last {
                if last == .x {
                    z = nil
                } else if last == .z {
                    x = nil
                }
            }
            last = .y
        }
    }
    
    var z : CGFloat? {
        didSet {
            guard z != nil else {
                return
            }
            if let last = last {
                if last == .y {
                    x = nil
                } else if last == .x {
                    y = nil
                }
            }
            last = .z
        }
    }
}



import Foundation
import UIKit

public extension UILabel {
    public func numberOfLines(_ numberOfLines : Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }
}

extension UILabel : HasText {
    
    public var h_text : String {
        get {
            return text ?? ""
        }
        set {
            text = newValue
        }
    }
    
    public var h_textColor : UIColor {
        get {
            return textColor
        }
        set {
            textColor = newValue
        }
    }
    
    public var h_font : UIFont {
        get {
            return font
        }
        set {
            font = newValue
        }
    }
    
    public var h_textAlignment : NSTextAlignment {
        get {
            return textAlignment
        }
        set {
            textAlignment = newValue
        }
    }
}



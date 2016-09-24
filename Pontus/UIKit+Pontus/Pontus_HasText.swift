
import UIKit

public protocol HasText : class {
    var h_width : CGFloat { get }
    var h_text : String { get set }
    var h_textColor : UIColor { get set }
    var h_font : UIFont { get set }
    var h_textAlignment : NSTextAlignment { get set }
    var displayHeight : CGFloat { get }
}

public extension HasText {
    
    public var h_width : CGFloat {
        if self is UIView {
            return (self as! UIView).frame.size.width
        } else {
            ccLogWarning("\"HasText\" only support UIView")
            return 0
        }
    }
    
    func text(_ text:String?) -> Self {
        h_text = text ?? ""
        return self
    }
    
    func textColor(_ color: UIColor) -> Self {
        h_textColor = color
        return self
    }
    
    func font(_ font: UIFont) -> Self {
        h_font = font
        return self
    }
    
    func textAlignmentCenter() -> Self {
        h_textAlignment = .center
        return self
    }
    
    func textAlignment(_ textAlignment:NSTextAlignment) -> Self {
        h_textAlignment = textAlignment
        return self
    }
    
    func text(_ text : String?, textColor : UIColor) -> Self {
        return self.text(text).textColor(textColor)
    }
    
    func font(systemFontOfSize:CGFloat) -> Self {
        return font(UIFont.systemFont(ofSize: systemFontOfSize))
    }
    
    func fontSize(_ fontSize : CGFloat) -> Self {
        if let newSizeFont = UIFont(name: h_font.fontName, size: fontSize) {
            h_font = newSizeFont
        }
        return self
    }
    
    public var displayHeight : CGFloat {
        return (h_text as NSString).boundingRect(with: CGSize(width: h_width, height: CGFloat(MAXFLOAT)),
                                                         options: .usesLineFragmentOrigin,
                                                         attributes: [NSFontAttributeName:h_font], context: nil).size.height
    }
    
    public var singleLineDisplayWidth : CGFloat {
        return (h_text as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: h_font.lineHeight),
                                                         options: .usesLineFragmentOrigin,
                                                         attributes: [NSFontAttributeName:h_font], context: nil).size.width
    }
}

public extension UIFont {
    static var systemFontName : String {
        return UIFont.systemFont(ofSize: 12).fontName
    }
}

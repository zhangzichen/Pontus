

import Foundation

// TODO: ⚠️ UnFinish!

// TODO: 准确的知道一个 NSDate 应该转成多少天前，多少小时前，多少小时后，多少天后！

private extension NSDate {
    
    private static var parser : NSDateFormatter! = nil
    
    var isToday : Bool {
        return true
    }
    
    var isTomorrow : Bool {
        return true
    }
    
    var isYesterday : Bool {
        return true
    }
    
    var tian : String {
        return "今天"
    }
    
    static func chineseDate(dateString: String, dateFormat:String = "yyyy-MM-dd HH:mm:ss", timezone:NSTimeZone = NSTimeZone(forSecondsFromGMT: 8)) -> NSDate? {
        
        if parser == nil {
            parser = NSDateFormatter()
        }
        
        parser.dateFormat = dateFormat
        parser.timeZone = timezone
        
        return parser.dateFromString(dateString)
    }
}


public extension NSDateFormatter {
    /// 直接使用 dateFormat 初始化一个 NSDateFormatter
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}

public extension Int {
    
    /// 直接转化成 NSDate
    var date: NSDate {
        return NSDate(timeIntervalSince1970: NSTimeInterval(self))
    }
    
    /// 除以 1000 后转化成 NSDate
    ///
    /// 从 Java 服务器获取的时间戳通常要除以1000
    var dateDivideByAThousand: NSDate {
        return NSDate(timeIntervalSince1970: NSTimeInterval(self / 1000))
    }
}
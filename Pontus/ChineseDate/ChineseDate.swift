

import Foundation

// TODO: ⚠️ UnFinish!

// TODO: 准确的知道一个 NSDate 应该转成多少天前，多少小时前，多少小时后，多少天后！

private extension Date {
    
    static var parser : DateFormatter! = nil
    
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
    
    static func chineseDate(_ dateString: String, dateFormat:String = "yyyy-MM-dd HH:mm:ss", timezone:TimeZone = TimeZone(secondsFromGMT: 8)!) -> Date? {
        
        if parser == nil {
            parser = DateFormatter()
        }
        
        parser.dateFormat = dateFormat
        parser.timeZone = timezone
        
        return parser.date(from: dateString)
    }
}


public extension DateFormatter {
    /// 直接使用 dateFormat 初始化一个 NSDateFormatter
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}

public extension Int {
    
    /// 直接转化成 NSDate
    var date: Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
    
    /// 除以 1000 后转化成 NSDate
    ///
    /// 从 Java 服务器获取的时间戳通常要除以1000
    var dateDivideByAThousand: Date {
        return Date(timeIntervalSince1970: TimeInterval(self / 1000))
    }
}

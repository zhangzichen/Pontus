
import UIKit

open class PontusApplication {
    /// 获取缓存容量
    open static func GetCacheCapacity(_ result:(_ MB:Double, _ cachesFilePath:String?) -> Void) {
        /// 缓存文件大小
        var folderSize : Double = 0
        
        let _MB : Double = 1024 * 1024
        
        let manager = FileManager.default
        
        guard let cachesPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first else {
            result(folderSize, nil)
            return
        }
        
        let _fileNameS = manager.subpaths(atPath: cachesPath)
        
        guard let fileNameS = _fileNameS else {
            result(folderSize, cachesPath)
            return
        }
        
        for fileName in fileNameS {
            let filePath = cachesPath + "/" + fileName
            let attributes = try! manager.attributesOfItem(atPath: filePath)
            let sizeNumber = attributes[FileAttributeKey.size] as! NSNumber
            folderSize += sizeNumber.doubleValue
        }
        
        result(folderSize / _MB, cachesPath)
    }
    /// 清空缓存
    open static func CleanCache(_ finish : (_ success:Bool) -> Void) {
        let manager = FileManager.default
        guard let cachesPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first else {
            finish(false)
            return
        }
        
        let files = manager.subpaths(atPath: cachesPath)
        guard let fileNames = files else {
            finish(true)
            return
        }
        
        for fileName in fileNames {
            let filePath = cachesPath + "/" + fileName
            do {
                try manager.removeItem(atPath: filePath)
            } catch {
                
            }
        }
        finish(true)
    }
    /// 设置状态栏颜色
    open static func SetStatusBarStyle(_ style : UIStatusBarStyle, animated: Bool) {
        guard UIApplication.shared.statusBarStyle != style else {
            return
        }
        UIApplication.shared.setStatusBarStyle(style, animated: animated)
        
    }
    
    
    /// 当前应用版本号
    open static var Version : String {
        
        let unknownValue = "Unknown"
        
        guard let dictionary = Bundle.main.infoDictionary else {
            ccLogWarning("Can not find Info.plist")
            return unknownValue
        }
        
        guard let versionString = dictionary["CFBundleShortVersionString"] as? String else {
            ccLogWarning("CFBundleShortVersionString is not String")
            return unknownValue
        }
        
        return versionString
    }
    
    /// 当前应用编译号
    open static var Build : String {
        let unknownValue = "00001"
        
        guard let dictionary = Bundle.main.infoDictionary else {
            ccLogWarning("Can not find Info.plist")
            return unknownValue
        }
        
        guard let buildString = dictionary["CFBundleVersion"] as? String else {
            ccLogWarning("CFBundleVersion is not String")
            return unknownValue
        }
        
        return buildString
    }
}

//public var ScreenBounds : CGRect {
//    return UIScreen.mainScreen().bounds
//}

/// ScreenBounds
///
/// Only support portrait
public let ScreenBounds = UIScreen.main.bounds

/// ScreenHeight
///
/// Only support portrait
public var ScreenHeight : CGFloat {
    return ScreenBounds.size.height
}

/// ScreenWidth
///
/// Only support portrait
public var ScreenWidth : CGFloat {
    return ScreenBounds.size.width
}

/// 返回一个高度为 （屏幕高度 - 导航栏高度） 的 rect 值
public var OpaqueBarsBounds : CGRect {
    return CGRect(x: ScreenBounds.origin.x, y: ScreenBounds.origin.y, width: ScreenWidth, height: ScreenHeight - NavigationBarHeight)
}

/// 64
public var NavigationBarHeight : CGFloat = 64

/// 49
public var TabBarHeight : CGFloat = 49

/**
 - returns: 返回一个相对于 ScreenWidth 水平居中的 CGRect
 */
public func CM(y: CGFloatable, width: CGFloatable, height: CGFloatable) -> CGRect {
    return CGRect(x: (ScreenWidth - width)/2, y: y, width: width, height: height)
}

/**
 - returns: 返回一个相对于 ScreenWidth 水平居中，宽度为 ScreenWidth 的 CGRect
 */
public func SWCM(y: CGFloatable, height: CGFloatable) -> CGRect {
    return CGRect(x: 0, y: y, width: ScreenWidth, height: height)
}

public var CurrentSystemVersion : Float {
    return (UIDevice.current.systemVersion as NSString).floatValue
}


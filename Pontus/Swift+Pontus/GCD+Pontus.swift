
import Foundation

/**
 开启新线程，异步执行
 
 - parameter block: 做什么
 */
public func Async(_ block:@escaping () -> Void) {
    let queue = DispatchQueue(label: LogString + ".Async", attributes: [])
    queue.async(execute: block)
}

/**
 延迟执行
 
 - parameter second: 多少秒
 - parameter block:  做什么
 */
public func After(second : Double, _ block:@escaping ()->Void) {
    let when = DispatchTime.now() + Double(Int64(second * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    let queue = DispatchQueue.main
    queue.asyncAfter(deadline: when, execute: block)
}

/**
 最后执行某事，不阻碍 UI，在主线程中执行
 
 - parameter block: 做什么
 */
public func Last(_ block:@escaping () -> Void) {
    let queue = DispatchQueue.main
    queue.async(execute: block)
}

/**
 仅仅是为了快速调用 after
 */

public func After(second : Double) { }



import UIKit

public extension UIViewController {
    
    /// navigationController?.pushViewController(vc, animated: animated)
    func push(_ vc:UIViewController, animated:Bool = true) {
        navigationController?.pushViewController(vc, animated: animated)
    }
    
    func rightBarButtonItemTitle(_ title:String?, targetSelfAction action:Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.plain, target: self, action: action)
    }
    
    func leftBarButtonItemTitle(_ title:String?, targetSelfAction action:Selector) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.plain, target: self, action: action)
    }
    
    func hidesBottomBarWhenPushed(_ hidesBottomBarWhenPushed:Bool) -> Self {
        self.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        return self
    }
    
    /**
     直接设置 self.view.backgroundColor
     
     - parameter backgroundColor: 背景颜色
     
     - returns: self
     */
    func backgroundColor(_ backgroundColor : UIColor) -> Self{
        _ = view.backgroundColor(backgroundColor)
        return self
    }
    /**
     在 self.view 上添加 UIView
     
     - parameter viewsSubview: subView
     
     - returns: self
     */
    func addSubview(_ subviewForView : UIView) -> Self{
        view.addSubview(subviewForView)
        return self
    }
    
    func addSubviews(_ subviewsForView : [UIView]) -> Self {
        _ = view.addSubviews(subviewsForView)
        return self
    }
    
    func title(_ title : String?) -> Self {
        self.title = title
        return self
    }
    
    //  设置成true的话，表示即便UIViewController的navigationBar是不透明的，也会讲view上的scrollView的frame拓展到navigationBar下面。这样就使scrollView.frame在拥有透明或非透明的navigationBar中表现一致了。
    //  不过，这也许不是一个好办法。
    func extendedLayoutIncludesOpaqueBars(_ extendedLayoutIncludesOpaqueBars : Bool) -> Self {
        self.extendedLayoutIncludesOpaqueBars = extendedLayoutIncludesOpaqueBars
        return self
    }
    
    func automaticallyAdjustsScrollViewInsets(_ automaticallyAdjustsScrollViewInsets : Bool) -> Self {
        self.automaticallyAdjustsScrollViewInsets = automaticallyAdjustsScrollViewInsets
        return self
    }
    
    var navigationed : UINavigationController {
        return UINavigationController(rootViewController: self)
    }
    
}

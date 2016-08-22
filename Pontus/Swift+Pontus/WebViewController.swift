
import UIKit
import WebKit

//  https://github.com/ShingoFukuyama/WKWebViewTips

// MARK: - Properties & Init
class WebViewController: UIViewController {
    
    enum Style {
        case Light
        case Dark
        //        case Tint
    }
    
    weak var myNavigationController : UINavigationController?
    var staticTitle : String?
    var webView : WKWebView!
    var navigationBar : UIView!
    
    var style                = Style.Dark
    var urlString            = "http://www.baidu.com"
    let progressView         = UIProgressView(progressViewStyle: UIProgressViewStyle.Bar)
    let backButton           = UIButton()
    let closeButton          = UIButton()
    let titleLabel           = UILabel()
    var showBackString       = true
    
    var originStatusBarStyle = UIStatusBarStyle.Default
    var originInteractivePopGestureRecognizerEnable = true
    
    var maxLeft : CGFloat {
        //  左侧最右边的 button
        let leftButton = closeButton.hidden ? backButton : closeButton
        return leftButton.frame.origin.x + leftButton.frame.size.width + 8
    }
    
    var maxCenterWidth : CGFloat {
        return ScreenWidth - maxLeft * 2
    }
    
    init(staticTitle:String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.staticTitle = staticTitle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeObserver(self, forKeyPath: "title")
        webView.removeObserver(self, forKeyPath: "canGoForward")
    }
}

// MARK: - Lifecycle
extension WebViewController {
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text(staticTitle)
        
        switch style {
        case .Dark:
            navigationBar = UIVisualEffectView(blur: UIBlurEffectStyle.Dark)
        case .Light:
            navigationBar = UIView().backgroundColor(White)
        }
        
        let configuration = WKWebViewConfiguration()
        
        
        configuration.preferences = WKPreferences()
        configuration.preferences.minimumFontSize = 10
        configuration.preferences.javaScriptEnabled = true
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        
        /*
        var userToken = ""
        if AppCore.token == nil {
            userToken = "window.localStorage.setItem('moteApp',true);"
        }else {
            userToken = "var token = '\(AppCore.token!)';window.localStorage.setItem('token',token);window.localStorage.setItem('moteApp',true);"
        }
 
        
        let script = WKUserScript(source: userToken,
                                  injectionTime: .AtDocumentStart,// 在载入时就添加JS
            forMainFrameOnly: true) // 只添加到mainFrame中
        configuration.userContentController.addUserScript(script)
        configuration.userContentController.addScriptMessageHandler(self, name: "appmodel")
         */
        
        configWebViewConfiguration(configuration)
        webView = WKWebView(frame: CM(y: 0, width: ScreenWidth, height: ScreenHeight), configuration: configuration)
        
        navigationBar.frame = CM(y: 0, width: ScreenWidth, height: NavigationBarHeight)
        
        webView.scrollView.backgroundColor(UIColor.grayColor())
        webView.scrollView.insetTop(44)
        webView.UIDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        
        
        //  保证在边缘滑动时不触发webView上的手势
        let screenEdgePanGestureRecognizerEnablePanView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: ScreenHeight))
        webView.addSubview(screenEdgePanGestureRecognizerEnablePanView)
        
        backButton
            .superView(navigationBar)
            .target(self, upInsideAction: #selector(WebViewController.back))
            .title(showBackString ? "返回" : "", titleColor: style == .Dark ? White : Red)
            .titleFontSize(15)
            .frame(x: 0, y: 20, width: 67, height: 44)  //WebViewNavigationBarBackIndicator
            .imageForNormal(UIImage(named: style == .Dark ? "backArrow" : "WebViewNavigationBarBackIndicator_DabaiMainColor"))
        backButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 14, bottom: 5, right: 67 - 26.5)
        backButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        
        navigationBar.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(WebViewController.close), forControlEvents: UIControlEvents.TouchUpInside)
        closeButton
            .title("关闭", titleColor: style == .Dark ? White : Red)
            .titleFontSize(15)
            .frame(x: 67, y: 20, width: 40, height: 44)
        closeButton.hidden = true
        
        navigationBar.addSubview(titleLabel)
        titleLabel.textColor(style == .Dark ? White : Red)
        let titleFrame = CGRect(x: maxLeft, y: 26, width: ScreenWidth - maxLeft, height: 30)
        titleLabel.frame(titleFrame)
        titleLabel.textAlignment(NSTextAlignment.Center)
        
        navigationBar.addSubview(progressView)
        progressView.frame = CM(y: NavigationBarHeight, width: ScreenWidth, height: 5)
        progressView.progressViewStyle = .Bar
        progressView.progressTintColor = RGB(50, 230, 50)
        progressView.trackTintColor = Clear
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.New, context: nil)
        webView.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.New, context: nil)
        webView.addObserver(self, forKeyPath: "canGoForward", options: NSKeyValueObservingOptions.New, context: nil)
        
        if style == .Light {
            let line = UIView(frame: CGRect(x: 0, y: 63.5, width: ScreenWidth, height: 0.5)).backgroundColor(HEX("c2c2c2"))
            navigationBar.addSubview(line)
            navigationBar.layer.shadowOffset = CGSizeMake(0, 0.3)
            navigationBar.layer.shadowOpacity = 0.1
            navigationBar.layer.shadowRadius = 0.5
        }
        
        backgroundColor(Black)
        addSubview(webView)
        addSubview(navigationBar)
        
        webView.loadRequest(NSURLRequest(URL: urlString.URL))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        originStatusBarStyle = UIApplication.sharedApplication().statusBarStyle
        myNavigationController = navigationController
        myNavigationController?.setNavigationBarHidden(true, animated: true)
        
        if let enable = myNavigationController?.interactivePopGestureRecognizer?.enabled {
            originInteractivePopGestureRecognizerEnable = enable
        }
        
        PontusApplication.SetStatusBarStyle(style == .Dark ? .LightContent : .Default, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        myNavigationController?.interactivePopGestureRecognizer?.enabled = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        myNavigationController?.setNavigationBarHidden(false, animated: true)
        PontusApplication.SetStatusBarStyle(originStatusBarStyle, animated: true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        myNavigationController?.interactivePopGestureRecognizer?.delegate = nil
        myNavigationController?.interactivePopGestureRecognizer?.enabled = originInteractivePopGestureRecognizerEnable
        myNavigationController = nil
        webView.stopLoading()
    }
}

// MARK: - Methods
extension WebViewController {
    func configWebViewConfiguration(configuration:WKWebViewConfiguration) {
        
    }
    
    func back() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func close() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        guard let keyPath = keyPath else {
            return
        }
        
        switch keyPath {
        case "estimatedProgress":
            AnimateWithDuration(0.25, {
                progressView.progress = Float(webView.estimatedProgress)
                progressView.hidden = (webView.estimatedProgress == 1) ? true : false
                UIApplication.sharedApplication().networkActivityIndicatorVisible = (webView.estimatedProgress == 1) ? false : true
                adjustTitleLabelWidth()
            })
        case "title":
            adjustTitleLabelWidth()
        case "canGoForward":
            judgeShouldShowCloseButton()
        default:break
        }
        
        //        if webView.loading {
        //            // 手动调用JS代码
        //            let js = "passToken()";
        //            self.webView.evaluateJavaScript(js) { (_, _) -> Void in
        //                print("call js alert")
        //            }
        //
        //            UIView.animateWithDuration(0.55, animations: { () -> Void in
        //                self.progressView.alpha = 0.0;
        //            })
        //        }
    }
    
    func adjustTitleLabelWidth() {
        let title = staticTitle ?? (webView.title ?? (self.title ?? ""))
        titleLabel.text(title)
        let displayWidth = title.NS.boundingRectWithSize(CGSize(width: 0, height: 30), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes:[NSFontAttributeName: UIFont.systemFontOfSize(17)], context: nil).width
        if displayWidth < maxCenterWidth {
            titleLabel.frame(CM(y: 26, width: maxCenterWidth, height: 30))
                .textAlignment(NSTextAlignment.Center)
        } else {
            titleLabel.frame(x: maxLeft, y: 26, width: ScreenWidth - maxLeft, height: 30)
                .textAlignment(NSTextAlignment.Left)
        }
    }
    
    func judgeShouldShowCloseButton() {
        if webView.backForwardList.forwardItem != nil {
            closeButton.hidden = false
            adjustTitleLabelWidth()
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension WebViewController : UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = !webView.canGoBack
        return shouldBegin
    }
}


// MARK: - WKUIDelegate
extension WebViewController : WKUIDelegate {
    func webView(webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: () -> Void) {
        let alert = UIAlertController(title: "Tip", message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (_) -> Void in
            // We must call back js
            completionHandler()
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func webView(webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: (Bool) -> Void) {
        let alert = UIAlertController(title: "Tip", message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (_) -> Void in
            // 点击完成后，可以做相应处理，最后再回调js端
            completionHandler(true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (_) -> Void in
            // 点击取消后，可以做相应处理，最后再回调js端
            completionHandler(false)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func webView(webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: (String?) -> Void) {
        let alert = UIAlertController(title: prompt, message: defaultText, preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
            textField.textColor = UIColor.redColor()
        }
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (_) -> Void in
            // 处理好之前，将值传到js端
            completionHandler(alert.textFields![0].text!)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func webViewDidClose(webView: WKWebView) {
    }
    
    
}

extension WebViewController : WKScriptMessageHandler {
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        print(message.body)
        // 如果在开始时就注入有很多的名称，那么我们就需要区分来处理
        if message.name == "appmodel" {
            print("message name is AppModel")
        }
    }
}

extension WebViewController {
    static func showInViewController(vc:UIViewController, dismiss:(()->Void)? = nil) {
        
//        guard let window = vc.view.window else {
//            return
//        }
//        
//        UIGraphicsBeginImageContextWithOptions(ScreenBounds.size, false, UIScreen.mainScreen().scale)
//        
//        window.layer.renderInContext(UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        SignViewController.BackgroundScreenShot = image
//        UIGraphicsEndImageContext()
//        
//        image.blurredImageAsync(20, iterations: 3, ratio: 3) {
//            SignViewController.BackgroundBlurredImage = $0
//            let signVC = SignViewController()
//            SignViewController.currentInstance = signVC
//            signVC.dismissBlock = dismiss
//            signVC.shouldAnimate = true
//            let signNaviC = signVC.navigationed.barUseColor(Clear, tintColor: White)
//            vc.presentViewController(signNaviC, animated: false, completion: nil)
//        }
    }
}

// MARK: - WKNavigationDelegate
extension WebViewController : WKNavigationDelegate {
    
    func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        //  http://stackoverflow.com/questions/31955880/wkwebview-not-opening-some-target-blank-links
        let jsCode = "var allLinks = document.getElementsByTagName('a');if (allLinks) { var i;for (i=0; i<allLinks.length; i++) {var link = allLinks[i];var target = link.getAttribute('target');if (target && target == '_blank') {link.setAttribute('target','_self');} } }"
        webView.evaluateJavaScript(jsCode, completionHandler: nil)
    }
    
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        
        
        guard let url = navigationAction.request.URL else {
            decisionHandler(WKNavigationActionPolicy.Allow)
            return
        }
        
        ccRight(navigationAction.request.mainDocumentURL?.relativePath)
        
        /*
        let urlString = url.absoluteString
        switch AppContactHtml.isHtmlContact(url) {
        case "":
            ccRight("啥也没有")
            if !AppCore.HasSignIn {
                WebViewController.showInViewController(self, dismiss: { () -> Void in
                    if AppCore.HasSignIn {
                        self.viewDidLoad()
                    }
                })
            }
        case "login":
            ccRight("login")
        default:
            ccRight("default")
        }
 */
        //        -(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
        //        {
        //            if ([request.mainDocumentURL.relativePath isEqualToString:@"/alert"]) {
        //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"本地代码执行" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        //                [alert show];
        //                return false;  //执行本地代码，返回false不让网页读取网络资源
        //            }
        //
        //            return true;   //如没有location对应的属性，则读取网络相关资源
        //        }
        
        let regex = try! NSRegularExpression(pattern: "\\/\\/itunes\\.apple\\.com\\/", options: NSRegularExpressionOptions.CaseInsensitive)
        
        if regex.numberOfMatchesInString(urlString, options: NSMatchingOptions.ReportProgress, range: NSMakeRange(0, urlString.characters.count)) > 0 {
            
            UIApplication.sharedApplication().openURL(url)
            decisionHandler(WKNavigationActionPolicy.Cancel)
            return
            
        }
        
        decisionHandler(WKNavigationActionPolicy.Allow)
    }
    
    func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
        progressView.hidden = true
        //        loadingFailImageView.hidden = false
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webViewWebContentProcessDidTerminate(webView: WKWebView) {
        
    }
    
}

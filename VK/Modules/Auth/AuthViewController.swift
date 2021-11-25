//
//  AuthVC.swift
//  AuthVC
//
//  Created by Эмиль Яйлаев on 14.10.2021.
//

import UIKit
import WebKit
///Контроллер авторизации через VK
class AuthViewController:UIViewController{
    var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        let urlRequest = URLRequest.init(url: URL.init(string: Data.urls.authorizeUrl)!)
        webView.load(urlRequest)
    }
}

/// MARK: WKNavigationDelegate
extension AuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let urlStr = navigationAction.request.url?.absoluteString {
            print("url:"+urlStr)
            if let code = URL.getHashByName(url: urlStr,name: "code"){
                print("code")
                ServiceRequest.getJsonData(url: URL(string:Data.urls.accessTokenUrl(code: code))!, model: ModelAuth.self) { methodAuth in
                    guard let methodAuth = methodAuth else { return }
                    if methodAuth.error == nil {
                        DispatchQueue.main.async {
                            let defaults = UserDefaults.standard
                            defaults.set(methodAuth.access_token, forKey: Data.keys.tokenVK)
                            let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController =  storyBoard.instantiateViewController(withIdentifier: "main") as! MainViewController
                            self.present(newViewController, animated: true, completion: nil)
                            decisionHandler(.cancel)
                        }
                    }else{
                        DispatchQueue.main.async {
                            
                        }
                    }
                }
            }else{
                if URL.getHashByName(url: urlStr,name: "error") != nil{
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                decisionHandler(.allow)
            }
        }
    }
}

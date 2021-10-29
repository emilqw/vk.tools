//
//  AuthVC.swift
//  AuthVC
//
//  Created by Эмиль Яйлаев on 14.10.2021.
//

import UIKit
import WebKit

class AuthViewController:UIViewController, WKNavigationDelegate{
    var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        let urlRequest = URLRequest.init(url: URL.init(string: VK.urls.authorizeUrl)!)
        webView.load(urlRequest)
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let urlStr = navigationAction.request.url?.absoluteString {
            let urlParser = URLParser(url: urlStr)
            if let code = urlParser.checkHashByName(name: "code"){
                URLSession.shared.dataTask(with: URL(string:VK.urls.accessTokenUrl(code: code))!){data,response,error in
                    
                    if let error = error{print(error)
                        return
                    }
                    guard let data = data else { return }
                    do {
                        let methodAuth = try JSONDecoder().decode(MethodAuth.self, from: data)
                        if methodAuth.error == nil {
                            DispatchQueue.main.async {
                                let defaults = UserDefaults.standard
                                defaults.set(methodAuth.access_token, forKey: VK.keys.tokenVK)
                                let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let newViewController =  storyBoard.instantiateViewController(withIdentifier: "main") as! MainViewController
                                self.present(newViewController, animated: true, completion: nil)
                                decisionHandler(.cancel)
                            }
                        }else{
                            DispatchQueue.main.async {
                                
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            
                        }
                    }
                }.resume()
            }
            else{
                decisionHandler(.allow)
            }
        }
    }
}
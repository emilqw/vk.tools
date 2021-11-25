//
//  VKNavigationBar.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 23.11.2021.
//

import UIKit
@IBDesignable
class VKNavigationBar: UINavigationBar {
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        self.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "VKSansDisplay-Medium", size: 18)!]
    }
}
class VKNavigationController:UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "VKSansDisplay-Medium", size: 10 )!]
        self.navigationController?.navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "VKSansDisplay-Medium", size: 25)!], for: .normal)
        allUIControlState { key in
            self.navigationController?.navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "VKSansDisplay-Medium", size: 25)!], for: key)
        }
    }
    func allUIControlState( completion:@escaping (UIControl.State)->()){
        completion(UIControl.State.normal)
        completion(UIControl.State.highlighted)
        completion(UIControl.State.disabled)
        completion(UIControl.State.focused)
        completion(UIControl.State.selected)
        completion(UIControl.State.application)
        completion(UIControl.State.reserved)
    }
}


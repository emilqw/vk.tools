//
//  StartViewController.swift
//  StartViewController
//
//  Created by Эмиль Яйлаев on 14.10.2021.
//

import UIKit

class MainViewController:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        VK.auth.getServiceKey{accessToken in
            if let accessToken = accessToken {
                if let token = UserDefaults.standard.string(forKey: Data.keys.tokenVK) {
                    VK.auth.checkToken(accessToken: accessToken, token: token){ auth in
                        if auth {
                            self.goAppViewController()
                        }else {
                            self.goLoginViewController()
                        }
                    }
                }else {
                    self.goLoginViewController()
                }
            }
        }
    }
    func goLoginViewController(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "segueMain", sender: nil)
        }
    }
    func goAppViewController(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "segueApp", sender: nil)
            
        }
    }
}

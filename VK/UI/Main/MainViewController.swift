//
//  StartViewController.swift
//  StartViewController
//
//  Created by Эмиль Яйлаев on 14.10.2021.
//

import UIKit
/// Контроллер основной
/// Проверяет авторизованность пользователя
class MainViewController:UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getServiceKey()
    }
    ///Получает токен устройства и проверяет работоспособность пользовательского токена
    func getServiceKey(){
        VK.auth.getServiceKey{accessToken in
            guard let accessToken = accessToken else {return}
            guard let token = UserDefaults.standard.string(forKey: Data.keys.tokenVK) else {
                self.showLoginViewController()
                return
            }
            VK.auth.checkToken(accessToken: accessToken, token: token){ auth in
                if auth {
                    self.showAppViewController()
                }else {
                    self.showLoginViewController()
                }
            }
        }
    }
    ///Переход в окно Авторизации
    func showLoginViewController(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "segueMain", sender: nil)
        }
    }
    ///Переход в окно Приложения
    func showAppViewController(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "segueApp", sender: nil)
            
        }
    }
}

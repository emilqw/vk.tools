//
//  RegDateViewController.swift
//  RegDateViewController
//
//  Created by Эмиль Яйлаев on 21.10.2021.
//

import UIKit

class RegDateViewController:UIViewController {
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var regDateLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    @IBAction func onMyRegDate(_ sender: UIButton) {
        regDateLabel.text = ""
        activityIndicator.isHidden = false
        self.viewRegDate()
    }
    @IBAction func onUserRegDate(_ sender: UIButton) {
        regDateLabel.text = ""
        activityIndicator.isHidden = false
        if let textField = userIdTextField.text{
            var userId = ""
            if let url = URL(string: textField){
                userId = url.path
                if(userId.first == "/"){
                    userId.remove(at: userId.startIndex)
                }
            } else {
                userId = textField
            }
            self.viewRegDate(userId)
        }
    }
    func viewRegDate(_ userId:String? = nil){
        if let accessToken = UserDefaults.standard.string(forKey: VK.keys.tokenVK) {
            VKApi.users.get(accessToken: accessToken, userIds: userId){user in
                if let user = user {
                    if user.error == nil {
                        if user.response.count > 0 {
                            VKApi.getRegDate(userID: String(user.response[0].id!)){regDate in
                                if let regDate = regDate {
                                    DispatchQueue.main.async {
                                        self.activityIndicator.isHidden = true
                                        self.regDateLabel.text = "Дата регистрации: "+regDate
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                        self.activityIndicator.isHidden = true
                                        self.regDateLabel.text = "Ошибка: Дата регистрации не найдена!"
                                    }
                                }
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.activityIndicator.isHidden = true
                                self.regDateLabel.text = "Ошибка: Пользователь не найден!"
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.activityIndicator.isHidden = true
                            self.regDateLabel.text = user.error?.error_msg
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.activityIndicator.isHidden = true
                        self.regDateLabel.text = "Ошибка: Пользователь не найден!"
                    }
                }
            }
        } else {
            activityIndicator.isHidden = true
            regDateLabel.text = "Ошибка авторизации!"
        }
    }
}

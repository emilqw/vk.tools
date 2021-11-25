//
//  RegDateViewController.swift
//  RegDateViewController
//
//  Created by Эмиль Яйлаев on 21.10.2021.
//

import UIKit
/// Контроллер отображающий поиск даты регистрации в VK
class RegDateViewController:UIViewController {
    /// Поле ввода Id
    @IBOutlet weak var userIdTextField: UITextField!
    /// Строка Id
    var userIdText: String = ""
    /// Отображение даты регистрации
    @IBOutlet weak var regDateLabel: UILabel!
    /// Индикатор загрузки
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userIdTextField.text = userIdText
        if userIdText != "" {
            activityIndicator.isHidden = false
            viewRegDate(userIdText)
        }
    }
    /// Событие нажатия получает и отображает дату рождения текущего пользователя
    @IBAction func onMyRegDate(_ sender: UIButton) {
        regDateLabel.text = ""
        activityIndicator.isHidden = false
        self.viewRegDate()
    }
    /// Событие нажатия получает и отображает дату рождения пользователя по  Id
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
    /// Получает и отображает дату регистрации пользователя
    /// - Parameter userId: Id пользователя
    func viewRegDate(_ userId:String? = nil){
        guard let accessToken = UserDefaults.standard.string(forKey: Data.keys.tokenVK) else {
            activityIndicator.isHidden = true
            regDateLabel.text = "Ошибка авторизации!"
            return
        }
        VKApi.users.get(accessToken: accessToken, userIds: userId){ data, error in
            guard  error == nil else {
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = true
                    self.regDateLabel.text = ""
                    self.errorShow(message: error!.error_msg!)
                }
                return
            }
            guard let data = data else { return }
            VKApi.users.getRegDate(userId: String(data.response[0].id!)){regDate in
                guard let regDate = regDate else {
                    DispatchQueue.main.async {
                        self.activityIndicator.isHidden = true
                        self.regDateLabel.text = "Ошибка: Дата регистрации не найдена!"
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = true
                    self.regDateLabel.text = "Дата регистрации: "+regDate
                }
            }
        }
    }

}

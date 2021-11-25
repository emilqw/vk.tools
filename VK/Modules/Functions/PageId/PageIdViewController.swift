//
//  PageIdViewController.swift
//  PageIdViewController
//
//  Created by Эмиль Яйлаев on 22.10.2021.
//

import UIKit

/// Контроллер отображающий  Id страницы
class PageIdViewController:UIViewController {
    ///  Отображение типа страницы
    @IBOutlet weak var pageTypeLabel: UILabel!
    /// Отображение  Id  страницы
    @IBOutlet weak var pageIdLabel: UILabel!
    /// Отображение ссылок на страницы
    @IBOutlet weak var linkLabel: InteractiveLinkLabel!
    /// Поле ввода Id  пользователя
    @IBOutlet weak var pageIdTextField: UITextField!
    /// Строка Id
    var pageIdText:String = ""
    /// Индикатор загрузки
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageIdTextField.text = pageIdText
        if pageIdText != "" {
            activityIndicator.isHidden = false
            viewPageId(pageIdText)
        }
    }
    
    /// Событие нажатия получает и отображает Id текущего пользователя
    @IBAction func onMyId(_ sender: UIButton) {
        pageIdLabel.text = ""
        activityIndicator.isHidden = false
        viewPageId()
    }
    
    /// Событие нажатия получает и отображает Id страницы по ссылке
    @IBAction func onPageId(_ sender: UIButton) {
        pageIdLabel.text = ""
        activityIndicator.isHidden = false
        if let textField = pageIdTextField.text{
            var pageId = ""
            if let url = URL(string: textField){
                pageId = url.path
                if(pageId.first == "/"){
                    pageId.remove(at: pageId.startIndex)
                }
            } else {
                pageId = textField
            }
            guard pageId.isInt else {
                guard let accessToken = UserDefaults.standard.string(forKey: Data.keys.tokenVK) else {
                    activityIndicator.isHidden = true
                    pageTypeLabel.text = "Ошибка авторизации!"
                    pageIdLabel.text = ""
                    self.linkLabel.text = ""
                    return
                }
                resolveScreenName(accessToken: accessToken, screenName: pageId)
                return
            }
            self.viewPageId(pageId)
            
        }
    }
    /// Отображает Id и тип страницы
    /// - Parameter pageId: Id страницы
    func viewPageId(_ pageId:String? = nil){
        guard
            let accessToken = UserDefaults.standard.string(forKey: Data.keys.tokenVK) else {
                
                activityIndicator.isHidden = true
                pageTypeLabel.text = "Ошибка авторизации!"
                pageIdLabel.text = ""
                self.linkLabel.text = ""
                return
            }
        VKApi.users.get(accessToken: accessToken, userIds: pageId, fields:Fields.create(.domain)){ data, error in
            guard  error == nil else {
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = true
                    self.pageTypeLabel.text = ""
                    self.pageIdLabel.text = ""
                    self.linkLabel.text = ""
                    self.errorShow(message: error!.error_msg!)
                }
                return
            }
            guard let data = data else { return }
            if let userDomain = data.response[0].domain{
                self.resolveScreenName(accessToken: accessToken, screenName:userDomain)
            } else {
                self.resolveScreenName(accessToken: accessToken, screenName: "id"+String(data.response[0].id!))
            }
        }
        
    }

    /// Получает тип страницы по Id
    /// - Parameters:
    ///   - accessToken: Ключ доступа
    ///   - screenName: Короткое имя пользователя, группы или приложения.
    func resolveScreenName(accessToken:String,screenName:String) {
        VKApi.utils.resolveScreenName(accessToken: accessToken, screenName:screenName){resolveScreenName in
            guard let resolveScreenName = resolveScreenName else {
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = true
                    self.pageTypeLabel.text = "Ошибка: Id страницы не найден!"
                    self.pageIdLabel.text = ""
                    self.linkLabel.text = ""
                }
                return
            }
            DispatchQueue.main.async {
                guard resolveScreenName.error == nil else {
                    self.activityIndicator.isHidden = true
                    self.pageTypeLabel.text = "Ошибка: Id страницы не найден!"
                    self.pageIdLabel.text = ""
                    self.linkLabel.text = ""
                    return
                }
                self.activityIndicator.isHidden = true
                var type = ""
                var typeURL = ""
                switch(resolveScreenName.response!.type){
                case "user":
                    type = "Пользователь"
                    typeURL = "id"
                    break
                case "group":
                    type = "Сообщество"
                    typeURL = "club"
                    break
                case "application":
                    type = "Приложение"
                    typeURL = "app"
                    break
                default:
                    break
                }
                self.pageTypeLabel.text = "Тип страницы: "+type
                self.pageIdLabel.text = "Номер страницы (ID):"+String(describing: resolveScreenName.response!.object_id)
                let urlVK = "https://vk.com/"
                let urlID = urlVK+typeURL+String(describing: resolveScreenName.response!.object_id)
                let urlDomain = urlVK+screenName
                let fullAttributedString = NSMutableAttributedString()
                fullAttributedString.append(NSMutableAttributedString(string: "Адрес страницы: ", attributes: nil))
                fullAttributedString.append(NSMutableAttributedString(string: urlDomain, attributes:[NSAttributedString.Key.link: URL(string: urlDomain)!]))
                fullAttributedString.append(NSMutableAttributedString(string: " или ", attributes: nil))
                fullAttributedString.append(NSMutableAttributedString(string: urlID, attributes:[NSAttributedString.Key.link: URL(string: urlID)!]))
                self.linkLabel.attributedText = fullAttributedString
                
            }
            
        }
    }
}

//
//  PageIdViewController.swift
//  PageIdViewController
//
//  Created by Эмиль Яйлаев on 22.10.2021.
//

import UIKit

class PageIdViewController:UIViewController {
    @IBOutlet weak var pageTypeLabel: UILabel!
    @IBOutlet weak var pageIdLabel: UILabel!
    @IBOutlet weak var linkLabel: InteractiveLinkLabel!
    @IBOutlet weak var pageIdTextField: UITextField!
    var pageIdText:String = ""
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBAction func onMyId(_ sender: UIButton) {
        pageIdLabel.text = ""
        activityIndicator.isHidden = false
        viewPageId()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pageIdTextField.text = pageIdText
        if pageIdText != "" {
            activityIndicator.isHidden = false
            viewPageId(pageIdText)
        }
    }
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
    func viewPageId(_ userId:String? = nil){
        guard
            let accessToken = UserDefaults.standard.string(forKey: Data.keys.tokenVK) else {
                
                activityIndicator.isHidden = true
                pageTypeLabel.text = "Ошибка авторизации!"
                pageIdLabel.text = ""
                self.linkLabel.text = ""
                return
            }
        VK.users.get(accessToken: accessToken, userIds: userId, fields:Fields.create(.domain)){user in
            guard let user = user else {
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = true
                    self.pageTypeLabel.text = "Ошибка: Пользователь не найден!"
                    self.pageIdLabel.text = ""
                    self.linkLabel.text = ""
                }
                return
            }
            guard user.error == nil else {
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = true
                    self.pageTypeLabel.text = user.error?.error_msg
                    self.pageIdLabel.text = ""
                    self.linkLabel.text = ""
                }
                return
            }
            guard user.response.count > 0 else {
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = true
                    self.pageTypeLabel.text = "Ошибка: Пользователь не найден!"
                    self.pageIdLabel.text = ""
                    self.linkLabel.text = ""
                }
                return
            }
            if let userDomain = user.response[0].domain{
                self.resolveScreenName(accessToken: accessToken, screenName:userDomain)
            } else {
                self.resolveScreenName(accessToken: accessToken, screenName: "id"+String(user.response[0].id!))
            }
        }
        
    }
    func resolveScreenName(accessToken:String,screenName:String) -> Void {
        VK.utils.resolveScreenName(accessToken: accessToken, screenName:screenName){resolveScreenName in
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

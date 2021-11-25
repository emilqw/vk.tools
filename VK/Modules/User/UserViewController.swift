//
//  UserViewController.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 06.11.2021.
//

import UIKit
import WebKit
/// Контроллер отображающий профиль пользователя и его функционал
class UserViewController: UIViewController {
    /// Изображение пользователя
    @IBOutlet weak var image: VKImageView!
    /// Полное имя пользователя
    @IBOutlet weak var fullName: VKLabel!
    /// Статус пользователя
    @IBOutlet weak var status: UILabel!
    /// Индикатор загрузки страницы
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    /// Id пользователя
    var id:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.isHidden = true
        if let id = id {
            setUser(userId: id)
        } else {
            setUser()
        }
    }
    
    /// Событие нажатия на кнопку поиска даты регистрации
    @IBAction func onRegDate(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Functions", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegDate") as! RegDateViewController
        vc.userIdText = "id" + String(describing: id!)
        self.present(vc, animated: true, completion: nil)
    }
    
    /// Событие нажатия на кнопку поиска Id страницы
    @IBAction func onPageId(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Functions", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PageId") as! PageIdViewController
        vc.pageIdText = "id" + String(describing: id!)
        self.present(vc, animated: true, completion: nil)
    }
    
    /// Загрузка данных пользователя по Id
    /// - Parameter userId: Id пользователя
    func setUser(userId:Int? = nil){
        id = userId
        var uId:String?
        if let userId = userId {
            uId = String(describing: userId)
        }
        guard let accessToken = UserDefaults.standard.string(forKey: Data.keys.tokenVK) else  {
            indicator.isHidden = true
            self.errorShow(message: "Ошибка авторизации!")
            return
        }
        VKApi.users.get(accessToken: accessToken, userIds: uId,fields: Fields.create(.photo_max_orig,.status,.domain,.is_favorite)){ data, error in
            guard  error == nil else {
                DispatchQueue.main.async {
                    self.indicator.isHidden = true
                    self.errorShow(message: error!.error_msg!)
                }
                return
            }
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.id = data.response[0].id
                self.image.download(from: data.response[0].photo_max_orig!)
                self.image.isHidden = false
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
                self.image.addGestureRecognizer(tap)
                self.fullName.text = data.response[0].last_name! + " " + data.response[0].first_name!
                self.status.text = data.response[0].status
                self.navigationItem.title = "@" +  data.response[0].domain!
                self.indicator.isHidden = true
                if userId != nil {
                    let button: UIButton = UIButton()
                    //set image for button
                    //add function for button
                    //set frame
                    if data.response[0].is_favorite == 1{
                        self.updateButton(button: button, systemName: "star.fill", action: #selector(self.removePage))
                    } else {
                        self.updateButton(button: button, systemName: "star", action: #selector(self.addPage))
                    }
                    let barButton = UIBarButtonItem(customView: button)
                    self.navigationItem.rightBarButtonItem = barButton
                } else {
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Выйти", style: .plain, target: self, action: #selector(self.onLogout))
                }
            }
        }
    }
    func updateButton(button:UIButton,systemName:String,action:Selector){
        button.setImage(UIImage(systemName: systemName), for: .normal)
        button.setImage(UIImage(systemName: systemName), for: .highlighted)
        button.addTarget(self, action: action, for: .touchUpInside)
    }
    @objc func addPage(_ sender:UIButton){
        guard let accessToken = UserDefaults.standard.string(forKey: Data.keys.tokenVK) else {
            self.errorShow(message: "Ошибка авторизации!")
            return
        }
        guard let userId = id else {
            self.errorShow(message: "Id пользователя не найден!")
            return
        }
        VKApi.fave.addPage(accessToken: accessToken, userId: String(describing: userId)) { answer in
            guard let answer = answer else {
                DispatchQueue.main.async {
                self.errorShow(message: "Ошибка добавления закладки!")
                }
                return
            }
            guard answer.error == nil else {
                DispatchQueue.main.async {
                    self.errorShow(message: answer.error!.error_msg!)
                }
                return
            }
            guard answer.response == 1 else {
                DispatchQueue.main.async {
                self.errorShow(message: "Закладка не добавлена!")
                }
                return
            }
            DispatchQueue.main.async {
            self.updateButton(button: sender, systemName: "star.fill", action: #selector(self.removePage))
            }
        }
    }
    @objc func removePage(_ sender:UIButton){
        guard let accessToken = UserDefaults.standard.string(forKey: Data.keys.tokenVK) else {
            DispatchQueue.main.async {
            self.errorShow(message: "Ошибка авторизации!")
            }
            return
        }
        guard let userId = id else {
            self.errorShow(message: "Id пользователя не найден!")
            return
        }
        VKApi.fave.removePage(accessToken: accessToken, userId: String(describing: userId)) { answer in
            guard let answer = answer else {
                DispatchQueue.main.async {
                self.errorShow(message: "Ошибка удаления закладки!")
                }
                return
            }
            guard answer.error == nil else {
                DispatchQueue.main.async {
                    self.errorShow(message: answer.error!.error_msg!)
                }
                return
            }
            guard answer.response == 1 else {
                DispatchQueue.main.async {
                self.errorShow(message: "Закладка не удалена!")
                }
                return
            }
            DispatchQueue.main.async {
                self.updateButton(button: sender, systemName: "star", action: #selector(self.addPage))
            }
        }
        
    }
    /// Событие нажатия на кнопку выхода текущего пользователя из своего профиля
    @objc func onLogout(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Выход", message: "Вы уверены, что хотите выйти?", preferredStyle: .actionSheet)
        let okButton = UIAlertAction(title: "Да", style: .destructive) { sender in
            self.clearAllDataWKWebsite()
            let defaults = UserDefaults.standard
            defaults.set("", forKey: Data.keys.tokenVK)
            let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController =  storyBoard.instantiateViewController(withIdentifier: "main") as! MainViewController
            self.present(newViewController, animated: true, completion: nil)
        }
        let cancelButton = UIAlertAction(title: "Нет", style: .cancel)
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    /// Очистить весь кэш пользователя
    func clearAllDataWKWebsite(){
        URLCache.shared.removeAllCachedResponses()
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
    /// Событие по нажатию на изображение профиля открывает  его на весь экран
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    /// Событие по нажатию на открыток на весь экран изображение закрывает  его
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
}

//
//  UserViewController.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 06.11.2021.
//

import UIKit
/// Контроллер отображающий профиль пользователя и его функционал
class UserViewController: UIViewController {
    /// Изображение пользователя
    @IBOutlet weak var image: CustomImageView!
    /// Полное имя пользователя
    @IBOutlet weak var fullName: CustomLabel!
    /// Статус пользователя
    @IBOutlet weak var status: UILabel!
    /// Индикатор загрузки страницы
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    /// Id пользователя
    var id:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.isHidden = true
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
        guard let userId = userId else {
            image.isHidden = true
            fullName.isHidden = true
            status.isHidden = true
            indicator.isHidden = true
            return
        }
        guard let accessToken = UserDefaults.standard.string(forKey: Data.keys.tokenVK) else  {
            indicator.isHidden = true
            self.errorView(message: "Ошибка авторизации!")
            return
        }
        VK.users.get(accessToken: accessToken, userIds: "\(userId)",fields: Fields.create(.photo_max_orig,.status,.domain)){users in
            guard let users = users else {
                DispatchQueue.main.async {
                    self.indicator.isHidden = true
                    self.errorView(message:  "Пользователь не найден!")
                }
                return
            }
            guard users.error == nil else {
                DispatchQueue.main.async {
                    self.indicator.isHidden = true
                    self.errorView(message: users.error!.error_msg!)
                }
                return
            }
            guard users.response.count > 0 else {
                DispatchQueue.main.async {
                    self.indicator.isHidden = true
                    self.errorView(message:  "Пользователь не найден!")
                }
                return
            }
            DispatchQueue.main.async {
                self.image.download(from: users.response[0].photo_max_orig!)
                self.image.isHidden = false
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
                self.image.addGestureRecognizer(tap)
                self.fullName.text = users.response[0].last_name! + " " + users.response[0].first_name!
                self.status.text = users.response[0].status
                self.navigationItem.title = "@" +  users.response[0].domain!
                self.indicator.isHidden = true
            }
        }
    }
    
    /// Модальное окно с ошибкой
    /// - Parameter message: Сообщение ошибки
    func errorView(message:String){
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "ОК", style: .destructive)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
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

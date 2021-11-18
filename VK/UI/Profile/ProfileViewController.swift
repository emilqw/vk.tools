//
//  ProfileViewController.swift
//  ProfileViewController
//
//  Created by Эмиль Яйлаев on 14.10.2021.
//

import UIKit
import WebKit
/// Контроллер отображающий профиль текущего пользователя
class ProfileViewController: UIViewController {
    /// Изображение пользователя
    @IBOutlet weak var photoImageView: CustomImageView!
    /// Полное имя пользователя
    @IBOutlet weak var fullName: CustomLabel!
    /// Статус пользователя
    @IBOutlet weak var status: UILabel!
    /// Индикатор загрузки страницы
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    ///Получить и отобразить профиль пользователя
    func getProfile(){
        guard let accessToken = UserDefaults.standard.string(forKey: Data.keys.tokenVK) else { return}
        VK.users.get(accessToken: accessToken, fields: Fields.create(.domain,.status,.photo_max_orig)){user in
            guard let user = user else {return}
            DispatchQueue.main.async {
                self.fullName.text = user.response[0].last_name!+" "+user.response[0].first_name!
                self.status.text = user.response[0].status!
                self.navigationItem.title = "@"+user.response[0].domain!
                self.photoImageView.download(from: user.response[0].photo_max_orig!)
                self.indicatorView.isHidden = true
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
                self.photoImageView.addGestureRecognizer(tap)
            }
        }
    }
    /// Событие нажатия на кнопку выхода текущего пользователя из своего профиля
    @IBAction func onLogout(_ sender: UIButton) {
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
    
    ///  Событие по нажатию на открыток на весь экран изображение закрывает  его
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
}

//
//  ProfileViewController.swift
//  ProfileViewController
//
//  Created by Эмиль Яйлаев on 14.10.2021.
//

import UIKit
import WebKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileNavigationItem: UINavigationItem!
    @IBOutlet weak var photoImageView: CustomImageView!
    @IBOutlet weak var fullName: CustomLabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after loading the view.
        if let accessToken = UserDefaults.standard.string(forKey: Data.keys.tokenVK) {
            VK.users.get(accessToken: accessToken, fields: Fields.create(.domain,.status,.photo_max_orig)){user in
                if let user = user {
                    DispatchQueue.main.async {
                        self.fullName.text = user.response[0].last_name!+" "+user.response[0].first_name!
                        self.status.text = user.response[0].status!
                        self.profileNavigationItem.title = "@"+user.response[0].domain!
                        self.photoImageView.download(from: user.response[0].photo_max_orig!)
                        self.indicatorView.isHidden = true
                        let tap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
                        self.photoImageView.addGestureRecognizer(tap)
                    }
                }
            }
        }
    }
    @IBAction func onLogout(_ sender: Any) {
        let alert = UIAlertController(title: "Выйти", message: "Вы уверен, что хотите выйти?", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Да", style: .default) { sender in
            self.clearAllDataWKWebsite()
            let defaults = UserDefaults.standard
            defaults.set("", forKey: Data.keys.tokenVK)
            let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController =  storyBoard.instantiateViewController(withIdentifier: "main") as! MainViewController
            self.present(newViewController, animated: true, completion: nil)
        }
        let cancelButton = UIAlertAction(title: "Нет", style: .default) { sender in
        }
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
    
    func clearAllDataWKWebsite(){
        URLCache.shared.removeAllCachedResponses()
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
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
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
}



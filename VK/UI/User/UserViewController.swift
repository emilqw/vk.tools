//
//  UserViewController.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 06.11.2021.
//

import UIKit

class UserViewController: UIViewController {
    @IBOutlet weak var image: CustomImageView!
    @IBOutlet weak var fullName: CustomLabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var id:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.isHidden = true
    }
    @IBAction func onRegDate(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Functions", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegDate") as! RegDateViewController
        vc.userIdText = "id" + String(describing: id!)
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func onPageId(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Functions", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PageId") as! PageIdViewController
        vc.pageIdText = "id" + String(describing: id!)
        self.present(vc, animated: true, completion: nil)
    }
    func setUser(userId:Int? = nil){
        id = userId
        if let userId = userId {
            if let accessToken = UserDefaults.standard.string(forKey: Data.keys.tokenVK) {
                VK.users.get(accessToken: accessToken, userIds: "\(userId)",fields: Fields.create(.photo_max_orig,.status,.domain)){user in
                    if let user = user {
                        if user.error == nil {
                            if user.response.count > 0 {
                                DispatchQueue.main.async {
                                    self.image.download(from: user.response[0].photo_max_orig!)
                                    self.image.isHidden = false
                                    self.fullName.text = user.response[0].last_name! + " " + user.response[0].first_name!
                                    self.status.text = user.response[0].status
                                    self.navigationItem.title = "@" +  user.response[0].domain!
                                    self.indicator.isHidden = true
                                }
                            } else {
                                DispatchQueue.main.async {
                                    self.indicator.isHidden = true
                                    self.errorView(message:  "Пользователь не найден!")
                                }
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.indicator.isHidden = true
                                self.errorView(message: user.error!.error_msg!)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.indicator.isHidden = true
                            self.errorView(message:  "Пользователь не найден!")
                        }
                    }
                }
            } else {
                indicator.isHidden = true
                self.errorView(message: "Ошибка авторизации!")
            }
            
        }else {
            image.isHidden = true
            fullName.isHidden = true
            status.isHidden = true
            indicator.isHidden = true
        }
    }
    func errorView(message:String){
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "ОК", style: .destructive)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}

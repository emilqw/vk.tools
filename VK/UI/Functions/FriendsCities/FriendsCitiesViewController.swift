//
//  FriendsCitiesViewController.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 01.11.2021.
//

import UIKit

class FriendsCitiesViewController: UIViewController {
    var cities:[ResponseCitiesFriends] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var userIdTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func onMyFriendsCities(_ sender: Any) {
        cities = []
        tableView.reloadData()
        activityIndicator.isHidden = false
        self.viewCitiesFriends()
    }
    @IBAction func onUserFriendsCities(_ sender: Any) {
        cities = []
        tableView.reloadData()
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
            self.viewCitiesFriends(userId: userId)
        }
    }
    func viewCitiesFriends(userId:String? = nil){
        if let accessToken = UserDefaults.standard.string(forKey: Data.keys.tokenVK) {
            VK.users.get(accessToken: accessToken, userIds: userId){user in
                if let user = user {
                    if user.error == nil {
                        if user.response.count > 0 {
                            VK.friends.get(accessToken: accessToken,userId: String(user.response[0].id!), fields: Fields.create(.domain,.city,.photo_200_orig)){friends in
                                if let friends = friends {
                                    if friends.error == nil {
                                        if friends.response!.count > 0 {
                                            DispatchQueue.main.async {
                                                self.activityIndicator.isHidden = true
                                                self.cities = VK.friends.toCitiesState(friends:friends.response!).response
                                                self.tableView.reloadData()
                                            }
                                        }else {
                                            DispatchQueue.main.async {
                                                self.activityIndicator.isHidden = true
                                                self.errorView(message: "Друзья не найдены!")
                                            }
                                        }
                                    }else {
                                        DispatchQueue.main.async {
                                            self.activityIndicator.isHidden = true
                                            self.errorView(message: friends.error!.error_msg!)
                                        }
                                    }
                                }
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.activityIndicator.isHidden = true
                                self.errorView(message:  "Пользователь не найден!")
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.activityIndicator.isHidden = true
                            self.errorView(message: user.error!.error_msg!)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.activityIndicator.isHidden = true
                        self.errorView(message:  "Пользователь не найден!")
                    }
                }
            }
        } else {
            activityIndicator.isHidden = true
            self.errorView(message: "Ошибка авторизации!")
        }
        
    }
    func errorView(message:String){
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "ОК", style: .destructive)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}

extension FriendsCitiesViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = cities[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell") as! CityTableViewCell
        cell.setCity(cityTitle: city.cityTitle, value: city.value)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCityFriends", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ShowFriendsViewController {
            let i:Int = Int(tableView.indexPathForSelectedRow!.row)
            destination.navigation.title = cities[i].cityTitle
            destination.friends = cities[i].friends
        }
    }
}

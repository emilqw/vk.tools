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
        tableView.register(UINib(nibName: "ProgressInfoTableViewCell", bundle: nibBundle), forCellReuseIdentifier: "cell")
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
        guard let textField = userIdTextField.text else {return}
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
    func viewCitiesFriends(userId:String? = nil){
        guard let accessToken = UserDefaults.standard.string(forKey: Data.keys.tokenVK) else {
            activityIndicator.isHidden = true
            self.errorView(message: "Ошибка авторизации!")
            return
        }
        VK.users.get(accessToken: accessToken, userIds: userId){user in
            guard let user = user else {
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = true
                    self.errorView(message:  "Пользователь не найден!")
                }
                return
            }
            guard user.error == nil else {
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = true
                    self.errorView(message: user.error!.error_msg!)
                }
                return
            }
            guard user.response.count > 0 else  {
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = true
                    self.errorView(message:  "Пользователь не найден!")
                }
                return
            }
            VK.friends.get(accessToken: accessToken,userId: String(user.response[0].id!), fields: Fields.create(.domain,.city,.photo_200_orig)){friends in
                guard let friends = friends else {return}
                guard friends.error == nil else {
                    DispatchQueue.main.async {
                        self.activityIndicator.isHidden = true
                        self.errorView(message: friends.error!.error_msg!)
                    }
                    return
                }
                guard friends.response!.count > 0 else {
                    DispatchQueue.main.async {
                        self.activityIndicator.isHidden = true
                        self.errorView(message: "Друзья не найдены!")
                    }
                    return
                }
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = true
                    self.cities = VK.friends.toCitiesState(friends:friends.response!).response
                    self.tableView.reloadData()
                }
            }
            
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProgressInfoTableViewCell
        cell.setData(title: city.cityTitle, value: city.value)
        cell.setConstraint(constant: 0)
        if city.cityTitle == "Не указано"
        {
            
            cell.setTintColor(color: .red)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCityFriends", sender: self)
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ShowFriendsViewController {
            let i:Int = Int(tableView.indexPathForSelectedRow!.row)
            destination.navigation.title = cities[i].cityTitle
            destination.friends = cities[i].friends
        }
    }
}

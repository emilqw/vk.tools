//
//  FunctionsViewController.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 17.11.2021.
//

import UIKit
///Контроллер отображающий список функций
class FunctionsViewController: UIViewController {
    ///Таблица
    @IBOutlet weak var tableView: UITableView!
    ///Список функций
    var functions:[Int:[String:String]] = [
        0: [
            "name":"Дата регистрации",
            "description":"Узнать, когда была создана страница пользователя ВКонтакте.",
            "showId":"showRegDate"
        ],
        1:[
            "name":"Узнать ID страницы",
            "description":"Узнать ID любого пользователя, группы или сообщества ВКонтакте.",
            "showId":"showPageId"
            
        ],
        2:[
            "name":"Города друзей",
            "description":"Узнать, в каких городах проживают Ваши друзья или друзья другого пользователя социальной сети ВКонтакте. ",
            "showId":"showFriendsCities"
            
        ],
        3:[
            
            "name":"Общие друзья и группы",
            "description":"Узнать, какие общие друзья и сообщества есть у двух пользователей социальной сети ВКонтакте.",
            "showId":"showCommonFriendsGroups"
            
        ]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ShortInfoTableViewCell", bundle: nibBundle), forCellReuseIdentifier: "cell")
    }
}
extension FunctionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return functions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let function = functions[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ShortInfoTableViewCell {
            cell.cellTitle.text = String(describing: function!["name"]!)
            cell.cellDescription.text = String(describing: function!["description"]!)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        let function = functions[indexPath.row]
        performSegue(withIdentifier: function!["showId"]!, sender: self)
        
    }
}

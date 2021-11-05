//
//  ShowFriendsViewController.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 02.11.2021.
//

import UIKit

class ShowFriendsViewController: UIViewController {
    @IBOutlet weak var navigation: UINavigationItem!
    var friends:[ResponseItemFriendsGet] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
 
}
extension ShowFriendsViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friend = friends[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        cell.setUser(imageUrl: friend.photo_200_orig!, fullName: friend.last_name! + " " + friend.first_name!, info: friend.city?.title)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showUser", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserViewController {
            let i:Int = Int(tableView.indexPathForSelectedRow!.row)
            destination.setUser(userId: friends[i].id)
        }
    }
}

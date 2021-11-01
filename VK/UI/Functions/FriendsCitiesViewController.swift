//
//  FriendsCitiesViewController.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 01.11.2021.
//

import UIKit

class FriendsCitiesViewController: UIViewController {
    var friends:[ResponseItemFriendsGet] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        print("Good")
        // Do any additional setup after loading the view.
        if let accessToken = UserDefaults.standard.string(forKey: Data.keys.tokenVK) {
            VK.friends.get(accessToken: accessToken, fields: Fields.create(.domain,.city,.photo_200_orig)){friends in
                if let friends = friends {
                    DispatchQueue.main.async {
                        self.friends = friends.response!.items
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}
extension FriendsCitiesViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friend = friends[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendViewCell") as! FriendTableViewCell
        cell.setFriend(friend: friend)
        return cell
    }
}

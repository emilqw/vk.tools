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
        tableView.register(UINib(nibName: "ImageInfoTableViewCell", bundle: nibBundle), forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }
 
}
extension ShowFriendsViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friend = friends[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ImageInfoTableViewCell
        cell.cellImage.download(from:  friend.photo_200_orig!)
        cell.cellTitle.text = friend.last_name! + " " + friend.first_name!
        cell.cellDescription.text = friend.city?.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showUser", sender: nil)
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserViewController {
            let i:Int = Int(tableView.indexPathForSelectedRow!.row)
            destination.setUser(userId: friends[i].id)
        }
    }
}

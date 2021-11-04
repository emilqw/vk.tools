//
//  CommonFriendsGroupsViewController.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 05.11.2021.
//

import UIKit

class CommonFriendsGroupsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func onShowCommonFriends(_ sender: Any) {
        performSegue(withIdentifier: "showCommonFriends", sender: nil)
    }
    @IBAction func onCommonGroups(_ sender: Any) {
        performSegue(withIdentifier: "showCommonGroups", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CommonFriendsViewController {
//            let i:Int = Int(tableView.indexPathForSelectedRow!.row)
//            destination.navigation.title = cities[i].cityTitle
//            destination.friends = cities[i].friends
        }
        if let destination = segue.destination as? CommonGroupsViewController {
//            let i:Int = Int(tableView.indexPathForSelectedRow!.row)
//            destination.navigation.title = cities[i].cityTitle
//            destination.friends = cities[i].friends
        }
    }

}

//
//  CommonFriendsGroupsViewController.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 05.11.2021.
//

import UIKit

class CommonFriendsGroupsViewController: UIViewController {

    @IBOutlet weak var searchButton: VKButton!
    @IBOutlet weak var searchType: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let _ = segue.destination as? CommonFriendsViewController {
//            let i:Int = Int(tableView.indexPathForSelectedRow!.row)
//            destination.navigation.title = cities[i].cityTitle
//            destination.friends = cities[i].friends
        }
        if let _ = segue.destination as? CommonGroupsViewController {
//            let i:Int = Int(tableView.indexPathForSelectedRow!.row)
//            destination.navigation.title = cities[i].cityTitle
//            destination.friends = cities[i].friends
        }
    }
    @IBAction func onTypeSelected(_ sender: UISegmentedControl) {
        switch(sender.selectedSegmentIndex){
        case 0:
            searchButton.titleLabel?.font = UIFont(name: "VKSansDisplay-Medium", size: 18)
            searchButton.setTitle("Поиск общих друзей", for: .normal)
            break
        case 1:
            searchButton.titleLabel?.font = UIFont(name: "VKSansDisplay-Medium", size: 18)
            searchButton.setTitle("Поиск общих сообществ", for: .normal)
            break
        default:
            break;
        }
    }
    
    @IBAction func onCommon(_ sender: UIButton) {
        switch(searchType.selectedSegmentIndex){
        case 0:
            performSegue(withIdentifier: "showCommonFriends", sender: nil)
            break
        case 1:
            performSegue(withIdentifier: "showCommonGroups", sender: nil)
            break
        default:
            break;
        }
    }
}

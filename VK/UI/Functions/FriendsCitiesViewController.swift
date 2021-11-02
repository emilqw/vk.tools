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
                        self.cities = VK.friends.toCitiesState(friends:friends.response!).response
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

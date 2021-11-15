//
//  FaveViewController.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 05.11.2021.
//

import UIKit

class FaveTableViewController:UITableViewController {
    var faves:[ResponseItemFave] = []
    var selectState = false
    @IBOutlet weak var selectButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        getPages()
        self.tableView.allowsMultipleSelectionDuringEditing = true
    }
    @IBAction func onSelect(_ sender: Any) {
        if selectState {
            self.selectButton.setTitle("Выбрать",for: .normal)
            self.tableView.isEditing = false
            self.selectState = false
        } else {
            self.selectButton.setTitle("Отмена", for: .normal)
            self.tableView.isEditing = true
            self.selectState = true
        }
    }
    func getPages(){
        if let accessToken = UserDefaults.standard.string(forKey: Data.keys.tokenVK) {
            VK.fave.getPages(accessToken: accessToken,fields: Fields.create(.photo_200_orig)){faves in
                if let faves = faves {
                    if faves.error == nil {
                        if faves.response!.items!.count > 0 {
                            DispatchQueue.main.async {
                                self.faves = faves.response!.items!
                                self.tableView.reloadData()
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.errorView(message:  "Заакладки не найдены!")
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.errorView(message: faves.error!.error_msg!)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorView(message:  "Закладки не найден!")
                    }
                }
            }
        } else {
            self.errorView(message: "Ошибка авторизации!")
        }
    }
    @IBAction func onRefresh(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        faves = []
        getPages()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faves.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fave = faves[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FaveTableViewCell") as! FaveTableViewCell
        cell.setFave(imageUrl: fave.user!.photo_200_orig!, name: fave.user!.last_name! + " " + fave.user!.first_name!, info: fave.description)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !selectState{
            performSegue(withIdentifier: "showUser", sender: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserViewController {
            let i:Int = Int(tableView.indexPathForSelectedRow!.row)
            destination.setUser(userId: faves[i].user!.id)
        }
    }
    func errorView(message:String){
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "ОК", style: .destructive)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}

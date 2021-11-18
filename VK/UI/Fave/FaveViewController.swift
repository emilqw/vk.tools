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
        tableView.register(UINib(nibName: "ImageInfoTableViewCell", bundle: nibBundle), forCellReuseIdentifier: "cell")
    }
    @IBAction func onSelect(_ sender: Any) {
        switch(selectState){
        case true:
            self.selectButton.setTitle("Выбрать",for: .normal)
            self.tableView.isEditing = false
            self.selectState = false
            break;
        case false:
            self.selectButton.setTitle("Отмена", for: .normal)
            self.tableView.isEditing = true
            self.selectState = true
            break;
        }
    }
    func getPages(){
        guard let accessToken = UserDefaults.standard.string(forKey: Data.keys.tokenVK) else {
            self.errorView(message: "Ошибка авторизации!")
            return
        }
        VK.fave.getPages(accessToken: accessToken,fields: Fields.create(.photo_200_orig)){faves in
            guard let faves = faves else {
                DispatchQueue.main.async {
                    self.errorView(message:  "Закладки не найден!")
                }
                return
            }
            guard faves.error == nil else {
                DispatchQueue.main.async {
                    self.errorView(message: faves.error!.error_msg!)
                }
                return
            }
            guard faves.response!.items!.count > 0 else {
                DispatchQueue.main.async {
                    self.errorView(message:  "Заакладки не найдены!")
                }
                return
            }
            DispatchQueue.main.async {
                self.faves = faves.response!.items!
                self.tableView.reloadData()
            }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ImageInfoTableViewCell
        cell.cellImage.download(from:  fave.user!.photo_200_orig!)
        cell.cellTitle.text = fave.user!.last_name! + " " + fave.user!.first_name!
        cell.cellDescription.text = fave.description
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

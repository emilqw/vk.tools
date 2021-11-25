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
    @IBOutlet weak var stackView:UIStackView!
    @IBOutlet weak var selectedButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        getPages()
        self.tableView.allowsMultipleSelectionDuringEditing = true
        tableView.register(UINib(nibName: "ImageInfoTableViewCell", bundle: nibBundle), forCellReuseIdentifier: "cell")
        stackView = createStackView(tableView: tableView)
        stackView.isHidden = false
        var _:[UIButton] = addButtonInStackView(stackView: stackView)
    }
    
    private func createStackView(tableView:UITableView) ->UIStackView{
        let stackView = UIStackView()
        stackView.isHidden = true
        stackView.axis  = .horizontal
        stackView.distribution  = .fill
        stackView.alignment = .center
        stackView.spacing   = 16
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        tableView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.widthAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        //stackView.layer.cornerRadius = 10
        //stackView.layer.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return stackView
    }
    func addButtonInStackView(stackView:UIStackView)->[UIButton]{
        let configuration = UIButton.Configuration.plain()
        let button = VKButton(configuration: configuration, primaryAction: nil)
        button.setTitle("Общие", for: .normal)
        button.titleLabel?.font = UIFont(name: "VKSansDisplay-Medium", size: 18)
        for names in UIFont.familyNames{
            let name = UIFont.fontNames(forFamilyName: names)
            print("\(names) : \(name)")
        }
        button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.numberOfLines = 1
            button.titleLabel?.minimumScaleFactor = 0.1
            button.clipsToBounds = true
        button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
        let button1 = VKButton(configuration: configuration, primaryAction: nil)
        button1.setTitle("Общие", for: .normal)
        button1.titleLabel?.adjustsFontSizeToFitWidth = true
            button1.titleLabel?.numberOfLines = 1
            button1.titleLabel?.minimumScaleFactor = 0.1
            button1.clipsToBounds = true
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(button1)
        return [button,button1]
    }
    @objc func onClick(_ sender:UIButton){
        print("clk")
    }
    @IBAction func onSelected(_ sender: UIBarButtonItem) {
        switch(selectState){
        case true:
            self.selectedButton.title = "Выбрать"
            self.tableView.isEditing = false
            self.selectState = false
            break;
        case false:
            self.selectedButton.title = "Отмена"
            self.tableView.isEditing = true
            self.selectState = true
            break;
        }
    }
    func getPages(){
        guard let accessToken = UserDefaults.standard.string(forKey: Data.keys.tokenVK) else {
            self.errorShow(message: "Ошибка авторизации!")
            return
        }
        VKApi.fave.getPages(accessToken: accessToken,fields: Fields.create(.photo_200_orig)){faves in
            guard let faves = faves else {
                DispatchQueue.main.async {
                    self.errorShow(message:  "Закладки не найдены!")
                }
                return
            }
            guard faves.error == nil else {
                DispatchQueue.main.async {
                    self.errorShow(message: faves.error!.error_msg!)
                }
                return
            }
            guard faves.response!.items!.count > 0 else {
                DispatchQueue.main.async {
                    self.errorShow(message:  "Заакладки не найдены!")
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
        cell.setConstraint(constant: 16)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !selectState{
            performSegue(withIdentifier: "showUser", sender: nil)
        } else {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
            print(tableView.indexPathsForSelectedRows!)
        }
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //print(tableView.indexPathsForSelectedRows!)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserViewController {
            let i:Int = Int(tableView.indexPathForSelectedRow!.row)
            destination.setUser(userId: faves[i].user!.id)
        }
    }

}

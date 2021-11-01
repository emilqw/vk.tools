//
//  UserTableViewCell.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 01.11.2021.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    @IBOutlet weak var userImageView: CustomImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setFriend(friend:ResponseItemFriendsGet){
        userImageView.download(from: friend.photo_200_orig!)
        fullNameLabel.text = friend.last_name! + " " + friend.first_name!
        if let city = friend.city{
            cityLabel.text = city.title
        }
        else {
            cityLabel.text  = ""
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

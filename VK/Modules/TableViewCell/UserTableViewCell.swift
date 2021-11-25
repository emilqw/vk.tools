//
//  UserTableViewCell.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 01.11.2021.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var userImageView: CustomImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUser(imageUrl:String,fullName:String,info:String?){
        userImageView.download(from: imageUrl)
        fullNameLabel.text = fullName
        if let info = info {
            infoLabel.isHidden = false
            infoLabel.text = info
        }
        else {
            infoLabel.isHidden = true
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  FaveTableViewCell.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 05.11.2021.
//

import UIKit

class FaveTableViewCell: UITableViewCell {
    @IBOutlet weak var faveImageView: CustomImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var info: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setFave(imageUrl:String,name:String,info:String?){
        faveImageView.download(from: imageUrl)
        self.name.text = name
        if let info = info {
            self.info.isHidden = false
            self.info.text = info
        }
        else {
            self.info.isHidden = true
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

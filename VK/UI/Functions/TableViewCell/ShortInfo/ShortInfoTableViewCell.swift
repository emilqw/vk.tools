//
//  FunctionTableViewCell.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 17.11.2021.
//

import UIKit

class ShortInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var rectangleRoundedView: UIView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

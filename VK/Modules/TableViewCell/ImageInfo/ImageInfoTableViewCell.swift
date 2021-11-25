//
//  ImageInfoTableViewCell.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 18.11.2021.
//

import UIKit

class ImageInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var cellImage: VKImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDescription: UILabel!
    @IBOutlet weak var cellImageChevronRight: UIImageView!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setConstraint(constant:CGFloat){
        leftConstraint.constant = constant
        rightConstraint.constant = constant
    }
}

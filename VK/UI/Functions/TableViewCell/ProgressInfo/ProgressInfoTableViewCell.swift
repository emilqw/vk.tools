//
//  ProgressInfoTableViewCell.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 18.11.2021.
//

import UIKit

class ProgressInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellValue: UILabel!
    @IBOutlet weak var cellImageChevronRight: UIImageView!
    @IBOutlet weak var cellProgress: UIProgressView!
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
    
    func setData(title:String,value:Float){
        self.cellTitle.text = title
        self.cellValue.text = "\(round(value * 100)/100)%"
        cellProgress.progress = Float(value/100)
    }
    func setConstraint(constant:CGFloat){
        leftConstraint.constant = constant
        rightConstraint.constant = constant
    }
    func setTintColor(color:UIColor){
        cellTitle.textColor = color
        cellValue.textColor = color
        cellProgress.progressTintColor = color
        cellImageChevronRight.tintColor = color
    }
}

//
//  CityTableViewCell.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 02.11.2021.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    @IBOutlet weak var cityTitle: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    func setCity(cityTitle:String,value:Float){
        self.cityTitle.text = cityTitle
        self.value.text = "\(round(value * 100)/100)%"
        progress.progress = Float(value/100)
        if cityTitle == "Не указано" {
            progress.tintColor = .red
        } else {
            progress.tintColor = .tintColor
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

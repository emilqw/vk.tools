//
//  VKLabel.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 22.11.2021.
//

import UIKit

@IBDesignable class VKLabel: UILabel {
    override func layoutSubviews() {
        super.layoutSubviews()
        font = UIFont(name: "VKSansDisplay-Medium", size: self.font.pointSize)
    }
}

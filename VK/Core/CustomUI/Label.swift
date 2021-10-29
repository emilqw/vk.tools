//
//  Label.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 28.10.2021.
//

import UIKit

@IBDesignable class CustomLabel: UILabel {
    @IBInspectable var skeleton: Bool = false{
        didSet{
            if(skeleton){
                layer.backgroundColor = UIColor.gray.cgColor
            }else{
                layer.backgroundColor = nil
            }
        }
    }
}

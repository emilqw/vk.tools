//
//  VKTextField.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 23.11.2021.
//

import Foundation
//
//  CustomTextField.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 22.11.2021.
//

import UIKit

@IBDesignable final class VKTextField: UITextField {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0{
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor?{
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    
    func setup() {
        cornerRadius = 8
        borderWidth = 2
        borderColor = #colorLiteral(red: 0, green: 0.4666666667, blue: 1, alpha: 1)
        let attributedPlaceholderText = NSAttributedString(
            string: self.placeholder ?? "",
            attributes: [
                //NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0.4666666667, blue: 1, alpha: 0.5) ,
                NSAttributedString.Key.font: UIFont(name: "VKSansDisplay-Medium", size: 18)!
            ]
        )
        
        self.attributedPlaceholder = attributedPlaceholderText
        self.font = UIFont(name: "VKSansDisplay-Medium", size: 18)!
        //self.textColor = #colorLiteral(red: 0, green: 0.4666666667, blue: 1, alpha: 1)
    }
    
}

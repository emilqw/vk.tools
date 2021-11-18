//
//  CustomView.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 17.11.2021.
//

import UIKit

@IBDesignable class CustomView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0.0{
        didSet{
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
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
    @IBInspectable override var backgroundColor: UIColor? {
        didSet{
            layer.backgroundColor = backgroundColor?.cgColor
        }
    }

}

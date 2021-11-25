//
//  VKButton.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 23.11.2021.
//

import UIKit
@IBDesignable
class VKButton: UIButton {
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
        titleLabel?.font = UIFont(name: "VKSansDisplay-Medium", size: 18)
        titleLabel?.clipsToBounds = true
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.clipsToBounds = true
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
        titleLabel?.font = getVKFont()
        setTitleColor(titleLabel?.textColor, for: .normal)
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        titleLabel?.font = UIFont(name: "VKSansDisplay-Medium", size: 18)
        setTitleColor(titleLabel?.textColor, for: .normal)
        if let title = titleLabel?.text {
            let attributedText = NSAttributedString(string: title, attributes: getAttributeFont())
            allUIControlState { key in
                self.setAttributedTitle(attributedText, for: key)
                super.setTitle(title, for: key)
            }
        }
    }
    override func setTitle(_ title: String?, for state: UIControl.State) {
        setAttributedFont(title)
    }
    func setAttributedFont(_ title:String?){
        if let title = title {
            let attributedText = NSAttributedString(string: title, attributes: getAttributeFont())
        allUIControlState { key in
            self.setAttributedTitle(attributedText, for: key)
            super.setTitle(title, for: key)
        }
        }
    }
    func getAttributeFont(_ size:CGFloat = 18)->[NSAttributedString.Key:Any]{
        return [NSAttributedString.Key.font: getVKFont(size)!]
    }
    func getVKFont(_ size:CGFloat = 18) ->UIFont? {
        return UIFont(name: "VKSansDisplay-Medium", size: size)
    }
    func allUIControlState( completion:@escaping (UIControl.State)->()){
        completion(UIControl.State.normal)
        completion(UIControl.State.highlighted)
        completion(UIControl.State.disabled)
        completion(UIControl.State.focused)
        completion(UIControl.State.selected)
        completion(UIControl.State.application)
        completion(UIControl.State.reserved)
    }
}

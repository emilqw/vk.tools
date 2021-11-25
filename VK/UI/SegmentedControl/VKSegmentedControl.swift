//
//  VKSegmentedControl.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 23.11.2021.
//

import UIKit

class VKSegmentedControl: UISegmentedControl {

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
            allUIControlState { key in
                self.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "VKSansDisplay-Medium", size: 15)!,NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0.4666666667, blue: 1, alpha: 1) ], for: key)
            }
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
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

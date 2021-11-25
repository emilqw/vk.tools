//
//  UIControl+allState.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 23.11.2021.
//

import Foundation
extension UIControl {
    func allState(completion:@escaping (UIControl.State)->()){
        completion(UIControl.State.normal)
        completion(UIControl.State.highlighted)
        completion(UIControl.State.disabled)
        completion(UIControl.State.focused)
        completion(UIControl.State.selected)
        completion(UIControl.State.application)
        completion(UIControl.State.reserved)
    }
}

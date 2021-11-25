//
//  UIViewController+ErrorShow.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 25.11.2021.
//

import Foundation
import UIKit
extension UIViewController {
    func errorShow(title:String? = nil,message:String?){
        let alert = UIAlertController(title: title ?? "Ошибка", message: message ?? "Неизвестная ошибка.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "ОК", style: .destructive)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

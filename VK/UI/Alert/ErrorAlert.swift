//
//  ErrorAlert.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 25.11.2021.
//

import Foundation
import UIKit
class ErrorAlert {
    static func show(_ vc:UIViewController,_ title:String?,message:String?){
        let alert = UIAlertController(title: title ?? "Ошибка", message: message ?? "Неизвестная ошибка.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "ОК", style: .destructive)
        alert.addAction(okButton)
        vc.present(alert, animated: true, completion: nil)
    }
}

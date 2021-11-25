//
//  String_IsInt.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 25.11.2021.
//

import Foundation
extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}

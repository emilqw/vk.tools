//
//  URLQueryItems.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 24.11.2021.
//

import Foundation
public class URLQueryItems {
    private var urlQueryItems:[URLQueryItem] = []
    func append(name:String,value:String?,optional:Bool = false)->URLQueryItems{
        if value != nil {
            urlQueryItems.append(URLQueryItem(name: name, value: value))
        } else {
            if optional {
                urlQueryItems.append(URLQueryItem(name: name, value: ""))
            }
        }
        return self
    }
    func append(name:String,value:Int?,optional:Bool = false)->URLQueryItems{
        if value != nil {
            urlQueryItems.append(URLQueryItem(name: name, value: String(describing: value)))
        } else {
            if optional {
                urlQueryItems.append(URLQueryItem(name: name, value: ""))
            }
        }
        return self
    }
    func getQueryItems() -> [URLQueryItem]{
        return urlQueryItems
    }
}

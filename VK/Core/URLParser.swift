//
//  URLParser.swift
//  URLParser
//
//  Created by Эмиль Яйлаев on 14.10.2021.
//

import Foundation
class URLParser{
    var url:String
    init(url:String){
        self.url = url
    }
    func getHash()->String?{
        let urlArray = url.components(separatedBy: "#")
        if urlArray.count > 1{
            return urlArray[1]
        }
        return nil
    }
    func checkHashByName(name:String) ->String?{
        if let hash = getHash(){
            let hashArray = hash.components(separatedBy: "&")
            for item in hashArray {
                if item.hasPrefix(name) {
                    let range: Range<String.Index> = item.range(of: "\(name)=")!
                    return String(item[range.upperBound...])
                }
            }
        }
        return nil
    }
}
class URLCreate{
    var method:String
    var queryItems:[URLQueryItem]
    init(method:String,queryItems:[URLQueryItem]){
        self.method = method
        self.queryItems = queryItems
    }
    func getUrl()->URL?{
        if var urlComponents = URLComponents(string: "https://api.vk.com/method/\(method)"){
            urlComponents.queryItems = queryItems
            return urlComponents.url
        }
        return nil
    }
}

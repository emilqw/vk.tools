//
//  URLParser.swift
//  URLParser
//
//  Created by Эмиль Яйлаев on 14.10.2021.
//

import Foundation

extension URL {
   static func getHash(url:String)->String?{
        let urlArray = url.components(separatedBy: "#")
        if urlArray.count > 1{
            return urlArray[1]
        }
        return nil
    }
    static func getHashByName(url:String,name:String) ->String?{
        if let hash = URL.getHash(url: url){
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
   static func createURLServiceVK(method:String,urlQueryItems:URLQueryItems) -> URL? {
        if var urlComponents = URLComponents(string: "https://api.vk.com/method/\(method)"){
            urlComponents.queryItems = urlQueryItems.getQueryItems()
            return urlComponents.url
        }
        return nil
    }
}

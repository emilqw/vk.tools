//
//  ServiceFave.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 05.11.2021.
//

import Foundation
class ServiceFave{
    static func getPages(accessToken:String,offset:String? = nil,count:String? = nil,type:String? = "users",fields:String? = nil,tagId:Int? = nil,v:String? = nil,completion: @escaping (ModelFave?)->()){
        var queryItems:[URLQueryItem] = Array()
        (offset != nil) ? queryItems.append(URLQueryItem(name: "offset", value: String(describing:offset))):()
        (count != nil) ? queryItems.append(URLQueryItem(name: "count", value: String(describing:count))):()
        (type != nil) ? queryItems.append(URLQueryItem(name: "type", value: String(describing:type ?? ""))):()
        queryItems.append(URLQueryItem(name: "fields", value: fields ?? ""))
        (tagId != nil) ? queryItems.append(URLQueryItem(name: "tag_id", value: String(describing:tagId))):()
        queryItems.append(URLQueryItem(name: "access_token", value: accessToken))
        queryItems.append(URLQueryItem(name: "v", value: v ?? Data.appConfig.version))
        let usersGetUrl = URLCreate(method: Methods.fave.getPages, queryItems: queryItems)
        guard let url = usersGetUrl.getUrl() else { return }
        print(url)
        URLSession.shared.dataTask(with: url){data, response, error in
            if let error = error{print(error)
                return
            }
            guard let data = data else { return }
            do {
                let faves = try JSONDecoder().decode(ModelFave.self, from: data)
                completion(faves)
            } catch {
                completion(nil)
            }
        }.resume()
    }
}

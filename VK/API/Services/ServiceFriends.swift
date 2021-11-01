//
//  Friends.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 29.10.2021.
//

import Foundation
class ServiceFriends{
    static func get(accessToken:String,userId:String? = nil,fields:String? = nil,order:String? = nil,listId:Int? = nil,count:Int? = nil,offset:Int? = nil,nameCase:String? = nil,ref:String? = nil,v:String? = nil,completion: @escaping (ModelFriendsGet?)->()){
        var queryItems:[URLQueryItem] = Array()
        (userId != nil) ? queryItems.append(URLQueryItem(name: "user_id", value: userId ?? "")):()
        queryItems.append(URLQueryItem(name: "fields", value: fields ?? ""))
        (order != nil) ? queryItems.append(URLQueryItem(name: "order", value: order ?? "")):()
        (listId != nil) ? queryItems.append(URLQueryItem(name: "list_id", value: String(describing:  listId))):()
        (count != nil) ? queryItems.append(URLQueryItem(name: "count", value: String(describing:count))):()
        (offset != nil) ? queryItems.append(URLQueryItem(name: "offset", value: String(describing:offset))):()
        (nameCase != nil) ? queryItems.append(URLQueryItem(name: "name_case", value: nameCase ?? "")):()
        (ref != nil) ? queryItems.append(URLQueryItem(name: "ref", value: ref ?? "")):()
        queryItems.append(URLQueryItem(name: "access_token", value: accessToken))
        queryItems.append(URLQueryItem(name: "v", value: v ?? Data.appConfig.version))
        let usersGetUrl = URLCreate(method: Methods.friends.get, queryItems: queryItems)
        guard let url = usersGetUrl.getUrl() else { return }
        print(url)
        URLSession.shared.dataTask(with: url){data, response, error in
            if let error = error{print(error)
                return
            }
            guard let data = data else { return }
            do {
                let friends = try JSONDecoder().decode(ModelFriendsGet.self, from: data)
                completion(friends)
            } catch {
                completion(nil)
            }
        }.resume()
    }
}

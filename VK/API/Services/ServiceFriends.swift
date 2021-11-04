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
    static func getMutual(accessToken:String,sourceUid:String? = nil,targetUid:String? = nil,targetUids:String? = nil,order:String? = nil,count:Int? = nil,offset:Int? = nil,v:String? = nil,completion: @escaping (ModelFriendsGetManual?)->()){
        var queryItems:[URLQueryItem] = Array()
        (sourceUid != nil) ? queryItems.append(URLQueryItem(name: "source_uid", value: sourceUid ?? "")):()
        queryItems.append(URLQueryItem(name: "target_uid", value: targetUid ?? ""))
        (targetUids != nil) ? queryItems.append(URLQueryItem(name: "target_uids", value: targetUids ?? "")):()
        (order != nil) ? queryItems.append(URLQueryItem(name: "order", value: order ?? "")):()
        (count != nil) ? queryItems.append(URLQueryItem(name: "count", value: String(describing:count))):()
        (offset != nil) ? queryItems.append(URLQueryItem(name: "offset", value: String(describing:offset))):()
        queryItems.append(URLQueryItem(name: "access_token", value: accessToken))
        queryItems.append(URLQueryItem(name: "v", value: v ?? Data.appConfig.version))
        let usersGetUrl = URLCreate(method: Methods.friends.getMutual, queryItems: queryItems)
        guard let url = usersGetUrl.getUrl() else { return }
        print(url)
        URLSession.shared.dataTask(with: url){data, response, error in
            if let error = error{print(error)
                return
            }
            guard let data = data else { return }
            do {
                let friends = try JSONDecoder().decode(ModelFriendsGetManual.self, from: data)
                completion(friends)
            } catch {
                completion(nil)
            }
        }.resume()
    }
    static func toCitiesState(friends:ResponseFriendsGet)->ModelCitiesFriends{
        var dictionaryCities:[String:[ResponseItemFriendsGet]] = [:]
        var responseCitiesFriends:[ResponseCitiesFriends] = []
        var notIndicated:[ResponseItemFriendsGet] = []
        for friend in friends.items {
            if let city = friend.city {
                if var array = dictionaryCities[city.title!] {
                    array.append(friend)
                    dictionaryCities[city.title!]  = array
                }
                else {
                    var array:[ResponseItemFriendsGet] = []
                    array.append(friend)
                    dictionaryCities[city.title!]  = array
                }
            } else {
                notIndicated.append(friend)
            }
        }
        for key in Array(dictionaryCities.keys){
            responseCitiesFriends.append(ResponseCitiesFriends(cityTitle: key, value: Float((Float(dictionaryCities[key]!.count)*Float(100)/Float(friends.count))), friends: dictionaryCities[key]!))
        }
        responseCitiesFriends = responseCitiesFriends.sorted{ $0.value > $1.value}
        responseCitiesFriends.append(ResponseCitiesFriends(cityTitle: "Не указано", value: Float((Float(notIndicated.count)*Float(100)/Float(friends.count))), friends: notIndicated))
        let citiesFriends:ModelCitiesFriends = ModelCitiesFriends(response: responseCitiesFriends)
        return citiesFriends
    }
}

//
//  ServiceFave.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 05.11.2021.
//

import Foundation
class ServiceFave{
    /// Возвращает страницы пользователей и сообществ, добавленных в закладки.
    /// - Parameters:
    ///   - accessToken: Ключ доступа.
    ///   - offset: Смещение относительно первого объекта в закладках пользователя для выборки определенного подмножества.
    ///   - count: Количество возвращаемых закладок.
    ///   - type: Типы объектов, которые необходимо вернуть. Возможные значения:
    ///   users — вернуть только пользователей;
    ///   groups — вернуть только сообщества;
    ///   hints — топ сообществ и пользователей.
    ///   Если параметр не указан — вернутся объекты пользователей и сообществ, добавленных в закладки, в порядке добавления.
    ///   - fields: Список дополнительных полей для объектов user и group, которые необходимо вернуть.
    ///   - tagId: Идентификатор метки, закладки отмеченные которой требуется вернуть.
    ///   - v: Используемая версия API.
    ///   - completion: Функция которая выполнится после успешного получения данных.
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

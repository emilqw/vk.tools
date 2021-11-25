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
        let urlQueryItems = URLQueryItems()
        .append(name: "offset", value: offset)
        .append(name: "count", value: count)
        .append(name: "type", value: type)
        .append(name: "fields", value: fields,optional: true)
        .append(name: "tag_id", value: tagId)
        .append(name: "access_token", value: accessToken,optional: true)
        .append(name: "v", value: v ?? Data.appConfig.version,optional: true)
        guard let url = URL.createURLServiceVK(method: Methods.fave.getPages, urlQueryItems: urlQueryItems) else { return }
        ServiceRequest.getJsonData(url: url, model: ModelFave.self) { data in
            completion(data)
        }
    }
    static func addPage(accessToken:String,userId:String,v:String? = nil,completion: @escaping (ModelFaveAddRemovePage?)->()){
        let urlQueryItems = URLQueryItems()
        .append(name: "user_id", value: userId,optional: true)
        .append(name: "access_token", value: accessToken,optional: true)
        .append(name: "v", value: v ?? Data.appConfig.version,optional: true)
        guard let url = URL.createURLServiceVK(method: Methods.fave.addPage, urlQueryItems: urlQueryItems) else { return }
        ServiceRequest.getJsonData(url: url, model: ModelFaveAddRemovePage.self) { data in
            completion(data)
        }
    }
    static func removePage(accessToken:String,userId:String,v:String? = nil,completion: @escaping (ModelFaveAddRemovePage?)->()){
        let urlQueryItems = URLQueryItems()
        .append(name: "user_id", value: userId,optional: true)
        .append(name: "access_token", value: accessToken,optional: true)
        .append(name: "v", value: v ?? Data.appConfig.version,optional: true)
        guard let url = URL.createURLServiceVK(method: Methods.fave.removePage, urlQueryItems: urlQueryItems) else { return }
        ServiceRequest.getJsonData(url: url, model: ModelFaveAddRemovePage.self) { data in
            completion(data)
        }
    }
}

//
//  Utils.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 29.10.2021.
//

import Foundation
/// Служебные методы API.
class ServiceUtils {
    /// Определяет тип объекта (пользователь, сообщество, приложение) и его идентификатор по короткому имени screen_name.
    /// - Parameters:
    ///   - accessToken: Ключ доступа.
    ///   - screenName: Короткое имя пользователя, группы или приложения. Например, apiclub, andrew или rules_of_war.
    ///   - v: Используемая версия API.
    ///   - completion: Функция которая выполнится после успешного получения данных.
    static func resolveScreenName(accessToken:String,screenName:String,v:String? = nil,completion: @escaping (ModelUtilsResolveScreenName?)->()){
        let urlQueryItems = URLQueryItems()
        .append(name: "screen_name", value: screenName, optional: true)
        .append(name: "access_token", value: accessToken, optional: true)
        .append(name: "v", value: v ?? Data.appConfig.version, optional: true)
        guard let url = URL.createURLServiceVK(method: Methods.utils.resolveScreenName, urlQueryItems: urlQueryItems) else { return }
        ServiceRequest.getJsonData(url: url, model: ModelUtilsResolveScreenName.self) { data in
            completion(data)
        }
    }
}

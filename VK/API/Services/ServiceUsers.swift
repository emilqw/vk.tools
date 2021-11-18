//
//  Users.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 29.10.2021.
//
import Foundation
/// Методы API для работы с данными пользователей VK.
class ServiceUsers {
    /**
     Возвращает расширенную информацию о пользователях.
     
     - parameter accessToken: Токен пользователя.
     - parameter userIds: Перечисленные через запятую идентификаторы пользователей или их короткие имена (screen_name). По умолчанию — идентификатор текущего пользователя.
     - parameter fields: Перечисленные через запятую дополнительные поля профилей, которые необходимо вернуть.
     - parameter nameCase: Токен пользователя.
     - parameter v: Токен пользователя.
     - parameter completion: Токен пользователя.
     - returns: void
     */
    
    /// Возвращает расширенную информацию о пользователях.
    /// - Parameters:
    ///   - accessToken: Ключ доступа.
    ///   - userIds: Перечисленные через запятую идентификаторы пользователей или их короткие имена (screen_name). По умолчанию — идентификатор текущего пользователя.
    ///   - fields: Перечисленные через запятую дополнительные поля профилей, которые необходимо вернуть.
    ///   - nameCase: падеж для склонения имени и фамилии пользователя. Возможные значения: именительный – nom, родительный – gen, дательный – dat, винительный – acc, творительный – ins, предложный – abl. По умолчанию nom.
    ///   - v: Используемая версия API.
    ///   - completion: Функция которая выполнится после успешного получения данных.
    static func get(accessToken:String,userIds:String? = nil,fields:String? = nil,nameCase:String? = nil,v:String? = nil,completion: @escaping (ModelUsersGet?)->()){
        var queryItems:[URLQueryItem] = Array()
        (userIds != nil) ? queryItems.append(URLQueryItem(name: "user_ids", value: userIds ?? "")):()
        queryItems.append(URLQueryItem(name: "fields", value: fields ?? ""))
        (nameCase != nil) ? queryItems.append(URLQueryItem(name: "name_case", value: nameCase ?? "")):()
        queryItems.append(URLQueryItem(name: "access_token", value: accessToken))
        queryItems.append(URLQueryItem(name: "v", value: v ?? Data.appConfig.version))
        let usersGetUrl = URLCreate(method: Methods.users.get, queryItems: queryItems)
        guard let url = usersGetUrl.getUrl() else { return }
        URLSession.shared.dataTask(with: url){data, response, error in
            if let error = error{print(error)
                return
            }
            guard let data = data else { return }
            do {
                let users = try JSONDecoder().decode(ModelUsersGet.self, from: data)
                completion(users)
            } catch {
                completion(nil)
            }
        }.resume()
    }
}

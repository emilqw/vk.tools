//
//  VKMethod.swift
//  VKMethod
//
//  Created by Эмиль Яйлаев on 21.10.2021.
//

import Foundation
/// Методы API для работы с данными VK.
class VKApi {
    /// Методы для работы с данными пользователей.
    static let users = UsersMethod.self
    /// Служебные методы.
    static let utils = Utils.self
    /**
     Метод получает дату регистрации пользователя по его ID.
     
     - parameter userID: ID пользователя VK.
     - returns: Void
     */
    static func getRegDate(userID:String, completion: @escaping (String?)->()){
        let url = String(format: "https://vk.com/foaf.php?id=%@", arguments: [userID])
        print(url)
        URLSession.shared.dataTask(with: URL(string: url)!){data,response,error in
            if let error = error{print(error)
                return
            }
            guard let data = data else { return }
            if var isoDate = String(bytes: data, encoding: .ascii){
                if let range1 = isoDate.range(of: "(<ya:created dc:date=\").*(\"\\/>)", options: .regularExpression) {
                    isoDate = String(isoDate[range1])
                    if let range2 = isoDate.range(of: "\".*\"", options: .regularExpression){
                        isoDate = String(isoDate[range2])
                        completion(
                            DateConvert.editFormat(date: isoDate, dateFormat: "\"yyyy-MM-dd'T'HH:mm:ssZ\"", localeIdentifier: "en_US_POSIX", dateFormatOutput: "dd MMMM YYYY в HH:mm:ss", localeIdentifierOutput: "ru_RU")
                        )
                    } else {
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}
/// Методы API для работы с данными пользователей VK.
class UsersMethod {
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
    static func get(accessToken:String,userIds:String? = nil,fields:String? = nil,nameCase:String? = nil,v:String? = nil,completion: @escaping (MethodUsersGet?)->()){
        var queryItems:[URLQueryItem] = Array()
        (userIds != nil) ? queryItems.append(URLQueryItem(name: "user_ids", value: userIds ?? "")):()
        queryItems.append(URLQueryItem(name: "fields", value: fields ?? ""))
        (nameCase != nil) ? queryItems.append(URLQueryItem(name: "name_case", value: nameCase ?? "")):()
        queryItems.append(URLQueryItem(name: "access_token", value: accessToken))
        queryItems.append(URLQueryItem(name: "v", value: v ?? VK.data.version))
        let usersGetUrl = URLCreate(method: "users.get", queryItems: queryItems)
        guard let url = usersGetUrl.getUrl() else { return }
        URLSession.shared.dataTask(with: url){data, response, error in
            if let error = error{print(error)
                return
            }
            guard let data = data else { return }
            do {
                let user = try JSONDecoder().decode(MethodUsersGet.self, from: data)
                completion(user)
            } catch {
                completion(nil)
            }
        }.resume()
    }
}
/// Служебные методы API.
class Utils {
    static func resolveScreenName(accessToken:String,screenName:String,v:String? = nil,completion: @escaping (MethodUtilsResolveScreenName?)->()){
        var queryItems:[URLQueryItem] = Array()
        queryItems.append(URLQueryItem(name: "screen_name", value: screenName))
        queryItems.append(URLQueryItem(name: "access_token", value: accessToken))
        queryItems.append(URLQueryItem(name: "v", value: v ?? VK.data.version))
        print(screenName)
        let utilsResolveScreenName = URLCreate(method: "utils.resolveScreenName", queryItems: queryItems)
        guard let url = utilsResolveScreenName.getUrl() else { return }
        print(url)
        URLSession.shared.dataTask(with: url){data, response, error in
            if let error = error{print(error)
                return
            }
            guard let data = data else { return }
            do {
                let page = try JSONDecoder().decode(MethodUtilsResolveScreenName.self, from: data)
                completion(page)
            } catch {
                completion(nil)
            }
        }.resume()
    }
}

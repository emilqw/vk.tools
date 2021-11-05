//
//  VKMethod.swift
//  VKMethod
//
//  Created by Эмиль Яйлаев on 21.10.2021.
//

import Foundation
/// Методы API для работы с данными VK.
class VK {
    /// Данные для приложения
    static let data = Data.self
    /// Методы для работы с авторизацией
    static let auth = ServiceAuth.self
    /// Методы для работы с данными пользователей.
    static let users = ServiceUsers.self
    /// Методы для работы с закладками.
    static let fave = ServiceFave.self
    /// Методы для работы с друзьями
    static let friends = ServiceFriends.self
    /// Служебные методы.
    static let utils = ServiceUtils.self
    /**
     Метод получает дату регистрации пользователя по его ID.
     
     - parameter userID: ID пользователя VK.
     - returns: Void
     */
    static func getRegDate(userID:String, completion: @escaping (String?)->()){
        let url = String(format: "https://vk.com/foaf.php?id=%@", arguments: [userID])
        print(url)
        URLSession.shared.dataTask(with: URL(string: url)!){data, response, error in
            if let error = error{print(error)
                return
            }
            guard let data = data else { return }
            if var isoDate = String(bytes: data, encoding: .ascii){
                if let range1 = isoDate.range(of: "(<ya:created dc:date=\").*(\"\\/>)", options: .regularExpression) {
                    isoDate = String(isoDate[range1])
                    if let range2 = isoDate.range(of: "\".*\"", options: .regularExpression){
                        isoDate = String(isoDate[range2])
                        let dateFormatter = DateFormatter()
                        completion(
                            dateFormatter.toString(dateValue: isoDate, dateFormat: "\"yyyy-MM-dd'T'HH:mm:ssZ\"", localeIdentifier: "en_US_POSIX", dateFormatOutput: "dd MMMM YYYY в HH:mm:ss", localeIdentifierOutput: "ru_RU")
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

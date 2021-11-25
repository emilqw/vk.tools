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
    static func get(accessToken:String,userIds:String? = nil,fields:String? = nil,nameCase:String? = nil,v:String? = nil,completion: @escaping (_ data:ModelUsersGet?,_ error:ModelError?)->()){
        let urlQueryItems = URLQueryItems()
            .append(name: "user_ids", value: userIds)
            .append(name: "fields", value: fields, optional: true)
            .append(name: "name_case", value: nameCase)
            .append(name: "access_token", value: accessToken, optional: true)
            .append(name: "v", value: v ?? Data.appConfig.version, optional: true)
        guard let url = URL.createURLServiceVK(method: Methods.users.get, urlQueryItems: urlQueryItems) else { return }
        print(url)
        ServiceRequest.getJsonData(url: url, model: ModelUsersGet.self) { data in
            guard let data = data else {
                completion(nil, ModelError( error_msg: "Нет данных."))
                return
            }
            guard data.error == nil else {
                completion(nil, ModelError(error_msg:ErrorMessageList.errorList[data.error!.error_code!]![0]))
                return
            }
            guard data.response.count > 0 else {
                completion(nil, ModelError( error_msg: "Пользователь не найден."))
                return
            }
            completion(data,nil)
        }
    }
    /**
     Метод получает дату регистрации пользователя по его ID.
     
     - parameter userID: ID пользователя VK.
     - returns: Void
     */
    static func getRegDate(userId:String, completion: @escaping (String?)->()){
        let url = String(format: "https://vk.com/foaf.php?id=%@", arguments: [userId])
        print(url)
        ServiceRequest.getData(url: URL(string: url)!){ data in
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
        }
    }
}

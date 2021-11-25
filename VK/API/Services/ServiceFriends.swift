//
//  Friends.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 29.10.2021.
//

import Foundation
/// Методы для работы с друзьями.
class ServiceFriends {
    
    /// Возвращает список идентификаторов друзей пользователя или расширенную информацию о друзьях пользователя (при использовании параметра fields).
    /// - Parameters:
    ///   - accessToken: Ключ доступа.
    ///   - userId: Идентификатор пользователя, для которого необходимо получить список друзей. Если параметр не задан, то считается, что он равен идентификатору текущего пользователя (справедливо для вызова с передачей access_token).
    ///   - fields: Список дополнительных полей, которые необходимо вернуть.
    ///   Доступные значения: nickname, domain, sex, bdate, city, country, timezone, photo_50, photo_100, photo_200_orig, has_mobile, contacts, education, online, relation, last_seen, status, can_write_private_message, can_see_all_posts, can_post, universities
    ///   - order: Порядок, в котором нужно вернуть список друзей. Допустимые значения:
    ///   hints — сортировать по рейтингу, аналогично тому, как друзья сортируются в разделе Мои друзья (Это значение доступно только для Standalone-приложений с ключом доступа, полученным по схеме Implicit Flow.).
    ///   random — возвращает друзей в случайном порядке.
    ///   name — сортировать по имени. Данный тип сортировки работает медленно, так как сервер будет получать всех друзей а не только указанное количество count. (работает только при переданном параметре fields). По умолчанию список сортируется в порядке возрастания идентификаторов пользователей.
    ///   - listId: Идентификатор списка друзей, полученный методом friends.getLists, друзей из которого необходимо получить. Данный параметр учитывается, только когда параметр user_id равен идентификатору текущего пользователя.
    ///   - count: Количество друзей, которое нужно вернуть.
    ///   - offset: смещение, необходимое для выборки определенного подмножества друзей.
    ///   - nameCase: падеж для склонения имени и фамилии пользователя. Возможные значения: именительный – nom, родительный – gen, дательный – dat, винительный – acc, творительный – ins, предложный – abl. По умолчанию nom.
    ///   - ref:
    ///   - v: Используемая версия API.
    ///   - completion: Функция которая выполнится после успешного получения данных.
    static func get(accessToken:String,userId:String? = nil,fields:String? = nil,order:String? = nil,listId:Int? = nil,count:Int? = nil,offset:Int? = nil,nameCase:String? = nil,ref:String? = nil,v:String? = nil,completion: @escaping (ModelFriendsGet?)->()){
        let urlQueryItems = URLQueryItems()
        .append(name: "user_id", value: userId)
        .append(name: "fields", value: fields, optional: true)
        .append(name: "order", value: order)
        .append(name: "list_id", value: listId)
        .append(name: "count", value: count)
        .append(name: "offset", value: offset)
        .append(name: "name_case", value: nameCase)
        .append(name: "ref", value: ref)
        .append(name: "access_token", value: accessToken, optional: true)
        .append(name: "v", value: v ?? Data.appConfig.version, optional: true)
        guard let url = URL.createURLServiceVK(method: Methods.friends.get, urlQueryItems: urlQueryItems) else { return }
        ServiceRequest.getJsonData(url: url, model: ModelFriendsGet.self) { data in
            completion(data)
        }
    }
    /// Возвращает список идентификаторов общих друзей между парой пользователей.
    /// - Parameters:
    ///   - accessToken: Ключ доступа.
    ///   - sourceUid: Идентификатор пользователя, чьи друзья пересекаются с друзьями пользователя с идентификатором target_uid. Если параметр не задан, то считается, что source_uid равен идентификатору текущего пользователя.
    ///   - targetUid: Идентификатор пользователя, с которым необходимо искать общих друзей.
    ///   - targetUids: Список идентификаторов пользователей, с которыми необходимо искать общих друзей.
    ///   - order: Порядок, в котором нужно вернуть список общих друзей. Допустимые значения: random - возвращает друзей в случайном порядке. По умолчанию — в порядке возрастания идентификаторов.
    ///   - count: Количество общих друзей, которое нужно вернуть. (по умолчанию – все общие друзья)
    ///   - offset: Смещение, необходимое для выборки определенного подмножества общих друзей.
    ///   - v: Используемая версия API.
    ///   - completion: Функция которая выполнится после успешного получения данных
    static func getMutual(accessToken:String, sourceUid:String? = nil, targetUid: String? = nil, targetUids: String? = nil, order:String? = nil, count:Int? = nil, offset:Int? = nil, v:String? = nil, completion: @escaping (ModelFriendsGetManual?)->()){
        let urlQueryItems = URLQueryItems()
        .append(name: "source_uid", value: sourceUid)
        .append(name: "target_uid", value: targetUid, optional: true)
        .append(name: "target_uids", value: targetUids)
        .append(name: "order", value: order, optional: true)
        .append(name: "count", value: count)
        .append(name: "offset", value: offset)
        .append(name: "access_token", value: accessToken, optional: true)
        .append(name: "v", value: v ?? Data.appConfig.version, optional: true)
        guard let url = URL.createURLServiceVK(method: Methods.friends.getMutual, urlQueryItems: urlQueryItems) else { return }
        ServiceRequest.getJsonData(url: url, model: ModelFriendsGetManual.self) { data in
            completion(data)
        }
    }
    /// Распределение пользователей по городам
    /// - Parameter friends: Пользователи
    /// - Returns: Возвращает модель списка пользователей по городам
    static func toCitiesState(friends:ResponseFriendsGet)->ModelCitiesFriends{
        var dictionaryCities:[String:[ResponseItemFriendsGet]] = [:]
        var responseCitiesFriends:[ResponseCitiesFriends] = []
        var notIndicated:[ResponseItemFriendsGet] = []
        //
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
        //
        for key in Array(dictionaryCities.keys){
            responseCitiesFriends.append(ResponseCitiesFriends(cityTitle: key, value: Float((Float(dictionaryCities[key]!.count)*Float(100)/Float(friends.count))), friends: dictionaryCities[key]!))
        }
        //Сортировка по уменьшению количества городов
        responseCitiesFriends = responseCitiesFriends.sorted{ $0.value > $1.value}
        responseCitiesFriends.append(ResponseCitiesFriends(cityTitle: "Не указано", value: Float((Float(notIndicated.count)*Float(100)/Float(friends.count))), friends: notIndicated))
        let citiesFriends:ModelCitiesFriends = ModelCitiesFriends(response: responseCitiesFriends)
        return citiesFriends
    }
}

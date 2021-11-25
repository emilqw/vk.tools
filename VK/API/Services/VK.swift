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
    /// Данные для работы с API
    static let api = VKApi.self
}
class VKApi {
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
}

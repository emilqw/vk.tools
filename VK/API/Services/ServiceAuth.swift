//
//  ServiceAuth.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 30.10.2021.
//

import Foundation
class ServiceAuth {
    
    /// Позволяет получить ключ доступа.
    /// - Parameter completion: Функция которая выполнится после успешного получения данных.
    static func getServiceKey(completion: @escaping (String?)->() ){
        let authorizeUrl = String(format: "%@?client_id=%@&client_secret=%@&v=%@&grant_type=client_credentials", arguments: [Data.appConfig.accessTokenUrl,Data.appConfig.clientId,Data.appConfig.clientSecret,Data.appConfig.version])
        let url = URL(string: authorizeUrl)!
        ServiceRequest.getJsonData(url: url, model: ModelAuth.self) { methodAuth in
            guard let methodAuth = methodAuth else { return }
            if methodAuth.access_token != nil {
                completion(methodAuth.access_token)
            }else{
                completion(nil)
            }
        }
    }
    /// Позволяет проверять валидность ключа доступа пользователя в iFrame, VK Mini Apps и Standalone-приложениях с помощью передаваемого в приложения параметра access_token.
    /// - Parameters:
    ///   - accessToken: Ключ доступа.
    ///   - token: Клиентский ключ доступа.
    ///   - completion: Функция которая выполнится после успешного получения данных.
    static func checkToken(accessToken:String,token:String, completion:@escaping (Bool)->()){
        let urlQueryItems = URLQueryItems()
            .append(name: "token", value: token,optional: true)
            .append(name: "client_secret", value: Data.appConfig.clientSecret,optional: true)
            .append(name: "access_token", value: accessToken,optional: true)
            .append(name: "v", value: Data.appConfig.version,optional: true)
        guard let url =  URL.createURLServiceVK(method: Methods.secure.checkToken, urlQueryItems: urlQueryItems) else { return }
        ServiceRequest.getJsonData(url: url, model: ModelSecureCheckToken.self){ data in
            guard let data = data else {
                completion(false)
                return
            }
            if data.error == nil {
                completion(true)
            }else{
                completion(false)
            }
        }
    }
}

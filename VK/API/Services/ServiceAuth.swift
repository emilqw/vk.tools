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
        URLSession.shared.dataTask(with: url){data, response, error in
            if let error = error{print(error)
                return
            }
            guard let data = data else { return }
            do {
                let methodAuth = try JSONDecoder().decode(ModelAuth.self, from: data)
                if methodAuth.access_token != nil {
                    completion(methodAuth.access_token)
                }else{
                    completion(nil)
                }
            } catch {
                completion(nil)
            }
        }.resume()
    }
    /// Позволяет проверять валидность ключа доступа пользователя в iFrame, VK Mini Apps и Standalone-приложениях с помощью передаваемого в приложения параметра access_token.
    /// - Parameters:
    ///   - accessToken: Ключ доступа.
    ///   - token: Клиентский ключ доступа.
    ///   - completion: Функция которая выполнится после успешного получения данных.
    static func checkToken(accessToken:String,token:String, completion:@escaping (Bool)->()){
        let urlComponents = URLCreate(method: Methods.secure.checkToken, queryItems: [
            URLQueryItem(name: "token", value: token),
            URLQueryItem(name: "client_secret", value: Data.appConfig.clientSecret),
            URLQueryItem(name: "access_token", value: accessToken),
            URLQueryItem(name: "v", value: Data.appConfig.version)
        ])
        guard let url = urlComponents.getUrl() else { return }
        URLSession.shared.dataTask(with: url){data, response, error in
            if let error = error{print(error)
                return
            }
            guard let data = data else { return }
            do {
                let secureCheckToken = try JSONDecoder().decode(ModelSecureCheckToken.self, from: data)
                print(secureCheckToken)
                if secureCheckToken.error == nil {
                        completion(true)
                }else{
                        completion(false)
                }
            } catch {
                    completion(false)
            }
        }.resume()
    }
}

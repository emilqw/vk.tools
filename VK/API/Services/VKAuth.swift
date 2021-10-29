//
//  VKAuth.swift
//  VKAuth
//
//  Created by Эмиль Яйлаев on 19.10.2021.
//
import Foundation
class VKAuth {
    static func getServiceKey(completion: @escaping (String?)->() ){
        let authorizeUrl = String(format: "%@?client_id=%@&client_secret=%@&v=%@&grant_type=client_credentials", arguments: [VK.data.accessTokenUrl,VK.data.clientId,VK.data.clientSecret,VK.data.version])
        let url = URL(string: authorizeUrl)!
        URLSession.shared.dataTask(with: url){data,response,error in
            if let error = error{print(error)
                return
            }
            guard let data = data else { return }
            do {
                let methodAuth = try JSONDecoder().decode(MethodAuth.self, from: data)
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
    static func checkToken(accessToken:String,token:String, completion:@escaping (Bool)->()){
        let urlComponents = URLCreate(method: "secure.checkToken", queryItems: [
            URLQueryItem(name: "token", value: token),
            URLQueryItem(name: "client_secret", value: VK.data.clientSecret),
            URLQueryItem(name: "access_token", value: accessToken),
            URLQueryItem(name: "v", value: VK.data.version)
        ])
        guard let url = urlComponents.getUrl() else { return }
        URLSession.shared.dataTask(with: url){data,response,error in
            if let error = error{print(error)
                return
            }
            guard let data = data else { return }
            do {
                let secureCheckToken = try JSONDecoder().decode(MethodSecureCheckToken.self, from: data)
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

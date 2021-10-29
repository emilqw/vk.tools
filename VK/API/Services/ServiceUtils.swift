//
//  Utils.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 29.10.2021.
//

import Foundation
/// Служебные методы API.
class ServiceUtils {
    static func resolveScreenName(accessToken:String,screenName:String,v:String? = nil,completion: @escaping (ModelUtilsResolveScreenName?)->()){
        var queryItems:[URLQueryItem] = Array()
        queryItems.append(URLQueryItem(name: "screen_name", value: screenName))
        queryItems.append(URLQueryItem(name: "access_token", value: accessToken))
        queryItems.append(URLQueryItem(name: "v", value: v ?? Data.appConfig.version))
        print(screenName)
        let utilsResolveScreenName = URLCreate(method: Methods.utils.resolveScreenName, queryItems: queryItems)
        guard let url = utilsResolveScreenName.getUrl() else { return }
        print(url)
        URLSession.shared.dataTask(with: url){data, response, error in
            if let error = error{print(error)
                return
            }
            guard let data = data else { return }
            do {
                let page = try JSONDecoder().decode(ModelUtilsResolveScreenName.self, from: data)
                completion(page)
            } catch {
                completion(nil)
            }
        }.resume()
    }
}

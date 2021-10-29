//
//  Data.swift
//  Data
//
//  Created by Эмиль Яйлаев on 14.10.2021.
//

struct VK {
    static let data = Data.self
    static let keys = Keys.self
    static let urls = URLs.self
}
struct Data {
    static let authUrl = "https://oauth.vk.com"
    static let authorizeUrl = authUrl+"/authorize"
    static let accessTokenUrl = authUrl+"/access_token"
    static let clientId = "7975047"
    static let clientSecret = "UFVBJ9E1UHfFFj38K4uu"
    static let display = "mobile"
    static let redirectUri = "https://oauth.vk.com/blank.html"
    static let scope = "offline"
    static let responseType = ["code":"code","token":"token"]
    static let version = "5.131"
    static let state = ""
}
struct Keys {
    static let tokenVK = "tokenVK"
}
struct URLs {
    static let authorizeUrl = String(format: "%@?client_id=%@&display=%@&redirect_uri=%@&scope=%@&response_type=%@&v=%@", arguments: [VK.data.authorizeUrl,VK.data.clientId,VK.data.display,VK.data.redirectUri,VK.data.scope,"code",VK.data.version])
    static func accessTokenUrl (code:String)->String{
        return String(format: "%@?client_id=%@&client_secret=%@&redirect_uri=%@&code=%@",arguments:[VK.data.accessTokenUrl,VK.data.clientId,VK.data.clientSecret,VK.data.redirectUri,code])
    }
}

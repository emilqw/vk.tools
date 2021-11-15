//
//  Data.swift
//  Data
//
//  Created by Эмиль Яйлаев on 14.10.2021.
//

struct Data {
    static let appConfig = AppConfig.self
    static let keys = Keys.self
    static let urls = URLs.self
}
struct AppConfig {
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
    static let authorizeUrl = String(format: "%@?client_id=%@&display=%@&redirect_uri=%@&scope=%@&response_type=%@&v=%@", arguments: [Data.appConfig.authorizeUrl, Data.appConfig.clientId, Data.appConfig.display, Data.appConfig.redirectUri, Data.appConfig.scope,"code", Data.appConfig.version])
    static func accessTokenUrl (code:String)->String{
        return String(format: "%@?client_id=%@&client_secret=%@&redirect_uri=%@&code=%@",arguments:[Data.appConfig.accessTokenUrl,Data.appConfig.clientId, Data.appConfig.clientSecret, Data.appConfig.redirectUri, code])
    }
}

//
//  MethodAuth.swift
//  MethodAuth
//
//  Created by Эмиль Яйлаев on 19.10.2021.
//

struct ModelAuth:Decodable {
    var access_token:String?
    var expires_in:Int?
    var user_id:Int?
    var error:String?
    var error_description:String?
}

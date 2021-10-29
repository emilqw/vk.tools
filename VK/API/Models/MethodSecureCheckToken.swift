//
//  MethodSecureCheckToken.swift
//  MethodSecureCheckToken
//
//  Created by Эмиль Яйлаев on 19.10.2021.
//

struct MethodSecureCheckToken:Decodable {
    
    var response:MethodSecureCheckTokenResponse
    var error:MethodError?
}
struct MethodSecureCheckTokenResponse:Decodable {
    
    var success:Int?
    var user_id:Int?
    var date:Int?
    var expire:Int?
}

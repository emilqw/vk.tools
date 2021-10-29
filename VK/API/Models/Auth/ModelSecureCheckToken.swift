//
//  MethodSecureCheckToken.swift
//  MethodSecureCheckToken
//
//  Created by Эмиль Яйлаев on 19.10.2021.
//

struct ModelSecureCheckToken:Decodable {
    var response:ResponseSecureCheckToken
    var error:ModelError?
}
struct ResponseSecureCheckToken:Decodable {
    var success:Int?
    var user_id:Int?
    var date:Int?
    var expire:Int?
}

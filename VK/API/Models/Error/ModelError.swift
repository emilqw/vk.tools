//
//  MethodError.swift
//  MethodError
//
//  Created by Эмиль Яйлаев on 19.10.2021.
//

struct ModelError:Decodable{
    var error_code:Int?
    var error_msg:String?
    var request_params:[ResponseRequestParams]?
}
internal struct ResponseRequestParams:Decodable{
    var key: String
    var value:String
}

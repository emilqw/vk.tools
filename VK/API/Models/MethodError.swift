//
//  MethodError.swift
//  MethodError
//
//  Created by Эмиль Яйлаев on 19.10.2021.
//

struct MethodError:Decodable{
    var error_code:Int?
    var error_msg:String?
    var request_params:[requestParamsResponse]?
}
struct requestParamsResponse:Decodable{
    var key: String
    var value:String
}

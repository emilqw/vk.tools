//
//  MethodUtilsResolveScreenName.swift
//  MethodUtilsResolveScreenName
//
//  Created by Эмиль Яйлаев on 22.10.2021.
//

struct ModelUtilsResolveScreenName:Decodable{
    var response:ResponseUtilsResolveScreenName?
    var error:ModelError?
}
struct ResponseUtilsResolveScreenName:Decodable{
    var object_id:Int
    var  type:String
}

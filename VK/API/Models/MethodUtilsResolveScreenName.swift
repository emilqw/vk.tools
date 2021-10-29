//
//  MethodUtilsResolveScreenName.swift
//  MethodUtilsResolveScreenName
//
//  Created by Эмиль Яйлаев on 22.10.2021.
//

import Foundation
struct MethodUtilsResolveScreenName:Decodable{
    var response:methodUtilsResolveScreenNameResponse?
    var error:MethodError?
}
struct methodUtilsResolveScreenNameResponse:Decodable{
    var object_id:Int
    var  type:String
}

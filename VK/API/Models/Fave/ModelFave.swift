//
//  ModelFave.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 05.11.2021.
//

import Foundation
struct ModelFave:Decodable {
    var response: ResponseFave?
    var error:ModelError?
}
struct ResponseFave:Decodable {
    var count:Int?
    var items:[ResponseItemFave]?
}
struct ResponseItemFave:Decodable{
    var description:String?
    var type:String?
    var group: ResponseGroupGet?
    var updated_date:Int?
    var user: ResponseUserGet?
}
struct ResponseGroupGet:Decodable {
    var id:Int?
    var name: String?
    var screen_name: String?
    var is_closed: Int?
    var type: String?
    var photo_50: String?
    var photo_100:String?
    var photo_200: String?
}

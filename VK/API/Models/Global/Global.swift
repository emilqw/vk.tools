//
//  Global.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 29.10.2021.
//

import Foundation
struct ResponseCountry:Decodable{
    var id: Int?
    var title: String?
}
struct ResponseCity:Decodable{
    var id: Int?
    var title: String?
}
struct ResponseLastSeen:Decodable{
    var platform: Int?
    var time: Int?
}
struct ResponseUniversity:Decodable{
    var city:Int?
    var country:Int?
    var education_form:String?
    var faculty:Int?
    var faculty_name:String?
    var id:Int?
    var name:String?
}
struct ResponseSizePhoto:Decodable{
    var height:Int
    var url:String
    var type:String
    var width:Int
}
struct ResponsePhoto:Decodable{
    var album_id:Int
    var date:Int
    var id:Int
    var owner_id:Int
    var has_tags:Bool
    var post_id:Int
    var sizes: [ResponseSizePhoto]
    var text:String
}
struct ResponseCrop:Decodable {
    var x:Int
    var y:Int
    var x2:Int
    var y2: Int
}
struct ResponseRect:Decodable {
    var x:Int
    var y:Int
    var x2:Int
    var y2: Int
}
struct ResponseCropPhoto:Decodable {
    var photo: ResponsePhoto
    var crop: ResponseCrop
    var rect: ResponseRect
}
struct ResponseOccupation: Decodable{
    var id:Int
    var name:String
    var type:String
}
struct ResponsePersonal:Decodable{
    var alcohol:Int
    var inspired_by:String
    var langs: [String]
    var life_main:Int
    var people_main:Int
    var smoking:Int
}

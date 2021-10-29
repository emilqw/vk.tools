//
//  ModelFriendsGet.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 29.10.2021.
//

struct ModelFriendsGet:Decodable{
    var response:ResponseFriendsGet?
    var error:ModelError?
}
struct ResponseFriendsGet:Decodable{
    var count:Int
    var items:[ResponseItemFriendsGet]
}
struct ResponseItemFriendsGet:Decodable {
    var first_name:String?
    var id:Int?
    var last_name: String?
    var can_access_closed:Bool?
    var is_closed: Bool?
    var sex: Int?
    var photo_50: String?
    var photo_100: String?
    var online: Int?
    var nickname: String?
    var domain: String?
    var city: ResponseCity?
    var country: ResponseCountry?
    var photo_200_orig: String?
    var has_mobile: Int?
    var can_post: Int?
    var can_see_all_posts: Int?
    var can_write_private_message: Int?
    var status: String?
    var last_seen: ResponseLastSeen?
    var university: Int?
    var university_name: String?
    var faculty: Int?
    var faculty_name: String?
    var graduation: Int?
    var relation: Int?
    var universities: [ResponseUniversity]?
    var track_code: String?
}

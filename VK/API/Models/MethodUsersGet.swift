//
//  Model.swift
//  Model
//
//  Created by Эмиль Яйлаев on 13.10.2021.
//
struct MethodUsersGet:Decodable
{
    var response:[methodUsersGetResponse]
    var error:MethodError?
}

struct methodUsersGetResponse:Decodable{
    var first_name:String?
    var id:Int?
    var last_name:String?
    var can_access_closed:Bool?
    var is_closed:Bool?
    var sex:Int?
    var screen_name:String?
    var photo_50:String?
    var photo_100:String?
    var online:Int?
    var verified:Int?
    var friend_status:Int?
    var nickname:String?
    var domain:String?
    var bdate:String?
    var city:cityResponse?
    var country:countryResponse?
    var timezone:Int?
    var photo_200:String?
    var photo_max:String?
    var photo_200_orig:String?
    var photo_400_orig:String?
    var photo_max_orig:String?
    var photo_id:String?
    var has_photo:Int?
    var has_mobile:Int?
    var is_friend:Int?
    var can_post:Int?
    var can_see_all_posts:Int?
    var can_see_audio:Int?
    var interests:String?
    var books:String?
    var tv:String?
    var quotes:String?
    var about:String?
    var games:String?
    var movies:String?
    var activities:String?
    var music:String?
    var can_write_private_message:Int?
    var can_send_friend_request:Int?
    var can_be_invited_group:Bool?
    var site:String?
    var status:String?
    var last_seen:lastSeenResponse?
    var crop_photo: cropPhotoResponse?
    var blacklisted:Int?
    var blacklisted_by_me:Int?
    var is_favorite:Int?
    var is_hidden_from_feed:Int?
    var common_count:Int?
    var occupation:occupationResponse?
    var career: [String]?
    var military: [String]?
    var university:Int?
    var university_name:String?
    var faculty:Int?
    var faculty_name:String?
    var graduation:Int?
    var education_form:String?
    var home_town:String?
    var relation:Int?
    var personal:personalResponse?
    var universities: [universitiesResponse]?
    var schools: [String]?
    var relatives: [String]?
}
struct cityResponse:Decodable{
    var id:Int
    var title:String
}
struct countryResponse:Decodable{
    var id:Int
    var title:String
}
struct lastSeenResponse:Decodable {
    var platform:Int
    var time:Int
}
struct universitiesResponse:Decodable{
    var city:Int
    var country:Int
    var education_form:String
    var faculty:Int
    var faculty_name:String
    var id:Int
    var name:String
}
struct sizePhotoResponse:Decodable{
    var height:Int
    var url:String
    var type:String
    var width:Int
}
struct photoResponse:Decodable{
    var album_id:Int
    var date:Int
    var id:Int
    var owner_id:Int
    var has_tags:Bool
    var post_id:Int
    var sizes: [sizePhotoResponse]
    var text:String
}
struct cropResponse:Decodable {
    var x:Int
    var y:Int
    var x2:Int
    var y2: Int
}
struct rectResponse:Decodable {
    var x:Int
    var y:Int
    var x2:Int
    var y2: Int
}
struct cropPhotoResponse:Decodable {
    var photo: photoResponse
    var crop: cropResponse
    var rect: rectResponse
}
struct occupationResponse: Decodable{
    var id:Int
    var name:String
    var type:String
}
struct personalResponse:Decodable{
    var alcohol:Int
    var inspired_by:String
    var langs: [String]
    var life_main:Int
    var people_main:Int
    var smoking:Int
}

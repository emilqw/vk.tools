//
//  Model.swift
//  Model
//
//  Created by Эмиль Яйлаев on 13.10.2021.
//
struct ModelUsersGet:Decodable
{
    var response:[ResponseUserGet]
    var error:ModelError?
}

struct ResponseUserGet:Decodable{
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
    var city:ResponseCity?
    var country:ResponseCountry?
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
    var last_seen:ResponseLastSeen?
    var crop_photo: ResponseCropPhoto?
    var blacklisted:Int?
    var blacklisted_by_me:Int?
    var is_favorite:Int?
    var is_hidden_from_feed:Int?
    var common_count:Int?
    var occupation:ResponseOccupation?
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
    var personal:ResponsePersonal?
    var universities: [ResponseUniversity]?
    var schools: [String]?
    var relatives: [String]?
}

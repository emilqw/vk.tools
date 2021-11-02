//
//  ModelCitiesFriends.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 02.11.2021.
//

import Foundation

struct ModelCitiesFriends {
    var response:[ResponseCitiesFriends]
}
struct ResponseCitiesFriends {
    var cityTitle:String
    var value:Float
    var friends:[ResponseItemFriendsGet]
}

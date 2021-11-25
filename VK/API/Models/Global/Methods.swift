//
//  Method.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 30.10.2021.
//

import Foundation

struct Methods {
    
    struct users {
        static let get = "users.get"
    }
    struct fave {
        static let getPages = "fave.getPages"
        static let addPage = "fave.addPage"
        static let removePage = "fave.removePage"
    }
    struct friends {
        static let get = "friends.get"
        static let getMutual = "friends.getMutual"
    }
    
    struct secure {
        static let checkToken = "secure.checkToken"
    }
    
    struct utils {
        static let resolveScreenName = "utils.resolveScreenName"
    }
}

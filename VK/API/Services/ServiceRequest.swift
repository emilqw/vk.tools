//
//  ServiceRequest.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 24.11.2021.
//

import UIKit
import Foundation
class ServiceRequest {
    public static func getData(url:URL,completion: @escaping (_ data:Foundation.Data?)->Void){
        URLSession.shared.dataTask(with: url){data, response, error in
            if let error = error{print(error)
                return
            }
            guard let data = data else {
                return
            }
            completion(data)
        }.resume()
    }
    
    public static func getJsonData<T:Decodable>(url:URL,model:T.Type,completion:@escaping (_ data:T?)->Void){
        URLSession.shared.dataTask(with: url){data, response, error in
            if let error = error{
                print(error)
                return
            }
            guard let data = data else { return }
            do {
                let dataModel = try JSONDecoder().decode(T.self, from: data)
                let _ = completion(dataModel)
            } catch {
                let _ = completion(nil)
            }
        }.resume()
    }
}

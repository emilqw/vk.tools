//
//  DateFormatter.swift
//  VK Tools
//
//  Created by Эмиль Яйлаев on 30.10.2021.
//

import Foundation
extension DateFormatter {
    func toString(dateValue:String,dateFormat:String,localeIdentifier:String,dateFormatOutput:String,localeIdentifierOutput:String)->String{
        self.locale = Locale(identifier: localeIdentifier)
        self.dateFormat = dateFormat
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: localeIdentifierOutput)
        dateFormatter.dateFormat = dateFormatOutput
        return dateFormatter.string(from: self.date(from:dateValue)!)
    }
}

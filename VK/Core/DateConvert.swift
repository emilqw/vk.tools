//
//  DateConvert.swift
//  DateConvert
//
//  Created by Эмиль Яйлаев on 22.10.2021.
//

import Foundation
class DateConvert{
    static func toDate(date:String,dateFormat:String,localeIdentifier:String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: localeIdentifier) // set locale to reliable US_POSIX
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from:date)!
    }
    static func toString(date:Date,dateFormat:String,localeIdentifier:String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: localeIdentifier)
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
    static func editFormat(date:String,dateFormat:String,localeIdentifier:String,dateFormatOutput:String,localeIdentifierOutput:String)->String{
        let stringToDate:Date = DateConvert.toDate(date: date, dateFormat: dateFormat, localeIdentifier: localeIdentifier)
        return DateConvert.toString(date: stringToDate, dateFormat: dateFormatOutput, localeIdentifier: localeIdentifierOutput)
    }
}

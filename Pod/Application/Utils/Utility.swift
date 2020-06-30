//
//  Utility.swift
//  Pod
//
//  Created by Gunter on 2020/06/30.
//  Copyright © 2020 Gunter. All rights reserved.
//

import Foundation

enum Times {
    case sec
    
    case min
    
    case hour
    
    case day
    
    case month
    
    var value: Int64 {
        switch self {
        case .sec:
            return 60
        case .min:
            return 60 * 60
        case .hour:
            return 24 * 60 * 60
        case .day:
            return 30 * 24 * 60 * 60
        case .month:
            return 12 * 30 * 24 * 60 * 60
        }
    }
}

enum SecondToTime {
    
    case sec(second: Int64)
    
    case min(second: Int64)
    
    case hour(second: Int64)
    
    case day(second: Int64)
    
    case month(second: Int64)
    
    case year(second: Int64)
    
    var time: String {
        switch self {
        case .sec(let second):
            return "\(second)\("second".localized)"
        case .min(let second):
            let time = second / Times.sec.value
            return "\(time)\("minute".localized)"
        case .hour(let second):
            let time = second / Times.min.value
            return "\(time)\("hour".localized)"
        case .day(let second):
            let time = second / Times.hour.value
            return "\(time)\("day".localized)"
        case .month(let second):
            let time = second / Times.day.value
            return "\(time)\("month".localized)"
        case .year(let second):
            let time = second / Times.month.value
            return "\(time)\("yaer".localized)"
        }
    }
    
}

public class Utility {
    
    class func SecondTimeConvert(sec: Int64) -> String {
        
        let SEC = 60
        
        let MIN = 60
        
        let HOUR = 24
        
        let DAY = 30
        
        let MONTH = 12
        
        if sec < SEC {
            return SecondToTime.sec(second: sec).time
        } else if (sec / (Times.sec.value)) < MIN {
            return SecondToTime.min(second: sec).time
        } else if (sec / (Times.min.value)) < HOUR {
            return SecondToTime.hour(second: sec).time
        } else if (sec / (Times.hour.value)) < DAY {
            return SecondToTime.day(second: sec).time
        } else if (sec / (Times.day.value)) < MONTH {
            return SecondToTime.month(second: sec).time
        } else {
            return SecondToTime.year(second: sec).time
        }
        
    }
    
    class func miliSecFromDate(date: String) -> Int64 {
        let strTime = date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let posix = NSLocale(localeIdentifier: "ko_KR")
        formatter.locale = posix as Locale
        let date = formatter.date(from: strTime)
        
        if let date = date {
            return date.millisecondsSince1970
        } else {
            return 0
        }
        
    }
    
}

extension Date {
    var millisecondsSince1970: Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds: Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
    
    func adding(hour: Int) -> Date {
         return Calendar.current.date(byAdding: .hour, value: hour, to: self)!
    }
    
}

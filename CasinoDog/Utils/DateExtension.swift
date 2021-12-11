//
//
//

import Foundation

extension Date {
    func snsFormat(to baseDate: Date = Date()) -> String {
        let components = Calendar.current.dateComponents(
            [
                .second,
                .minute,
                .hour,
                .day,
                .weekOfYear,
                .month,
                .year
            ],
            from: self,
            to: baseDate
        )

        if components.year! >= 1 {
            return "\(components.year!) 年前"
        } else if components.month! >= 1 {
            return "\(components.month!) ヶ月前"
        } else if components.weekOfYear! >= 1 {
            return "\(components.weekOfYear!) 週間前"
        } else if components.day! >= 1 {
            return "\(components.day!) 日前"
        } else if components.hour! >= 1 {
            return "\(components.hour!) 時間前"
        } else if components.minute! >= 1 {
            return "\(components.minute!) 分前"
        } else if components.second! >= 10 {
            return "\(components.second!) 秒前"
        } else {
            return "たった今"
        }
    }
}

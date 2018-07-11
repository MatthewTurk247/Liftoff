//
//  UtilityExtensions.swift
//  Liftoff
//
//  Created by Matthew Turk on 7/10/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation
import UIKit

private var formatters = [String: DateFormatter]()

extension DateFormatter {
    static var apiFormatter: DateFormatter {
        return getDateFormatter(with: "y-MM-dd")
    }
    
    static var apiISOFormatter: DateFormatter {
        return getDateFormatter(with: "yyyyMMdd'T'HHmmss'Z'",
                                locale: Locale(identifier: "en_US_POSIX"),
                                timeZone: TimeZone(secondsFromGMT: 0) ?? TimeZone.current)
    }
    
    static var countdownTimeFormatter: DateFormatter {
        return getDateFormatter(with: "h:mma") // 5:45PM
    }
    
    static var weekdayFormatter: DateFormatter {
        return getDateFormatter(with: "cccc") // Tuesday
    }
    
    static var longCountdownFormatter: DateFormatter {
        return getDateFormatter(with: "ccc, LLL dd") // Tues, Sept 12
    }
    
    // MARK: Private
    
    private static func getDateFormatter(with format: String, locale: Locale = Locale.current, timeZone: TimeZone = TimeZone.current) -> DateFormatter {
        if let formatter = formatters[format] {
            return formatter
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            formatter.locale = locale
            formatter.timeZone = timeZone
            formatters[format] = formatter
            return formatter
        }
    }
}

extension TimeInterval {
    static var oneWeek: TimeInterval {
        return 604_800 // 7 * 24 * 60 * 60
    }
    
    static var oneDay: TimeInterval {
        return 86_400 // 24 * 60 * 60
    }
    
    static var oneHour: TimeInterval {
        return 3600 // 60 * 60
    }
    
    static var oneMinute: TimeInterval {
        return 60
    }
}

extension UIView { // Constraints
    
    func constrainEdgesToSuperview() {
        constrainEdgesToSuperview(with: .zero)
    }
    
    func constrainEdgesToSuperview(with inset: UIEdgeInsets) {
        guard let superview = superview else { assertionFailure("must have a superview"); return }
        
        translatesAutoresizingMaskIntoConstraints = false
        superview.leftAnchor.constraint(equalTo: leftAnchor, constant: inset.left).isActive = true
        superview.topAnchor.constraint(equalTo: topAnchor, constant: inset.top).isActive = true
        superview.rightAnchor.constraint(equalTo: rightAnchor, constant: -inset.right).isActive = true
        superview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset.bottom).isActive = true
    }
}

extension UIView { // Actions
    class func performWithoutActions(block: () -> Void) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        block()
        CATransaction.commit()
    }

}

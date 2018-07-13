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

extension Optional {
    func `do`(block: (Wrapped) -> Void) {
        guard case .some(let unwrapped) = self else { return }
        block(unwrapped)
    }
}

extension String {
    
    /**
     Returns a country flag from an **uppercased** ISO Alpha-2 country code String
     Example usage: "US".flag()
     @return A flag emoji. Example: 🇺🇸
     */
    
    func flag() -> String {
        var flagString = ""
        
        let countryCodeList = ["AFG", "ALA", "ALB", "DZA", "ASM", "AND", "AGO", "AIA", "ATA", "ATG", "ARG", "ARM", "ABW", "AUS", "AUT", "AZE", "BHS", "BHR", "BGD", "BRB", "BLR", "BEL", "BLZ", "BEN", "BMU", "BTN", "BOL", "BES", "BIH", "BWA", "BVT", "BRA", "IOT", "BRN", "BGR", "BFA", "BDI", "CPV", "KHM", "CMR", "CAN", "CYM", "CAF", "TCD", "CHL", "CHN", "CXR", "CCK", "COL", "COM", "COG", "COD", "COK", "CRI", "CIV", "HRV", "CUB", "CUW", "CYP", "CZE", "DNK", "DJI", "DMA", "DOM", "ECU", "EGY", "SLV", "GNQ", "ERI", "EST", "ETH", "FLK", "FRO", "FJI", "FIN", "FRA", "GUF", "PYF", "ATF", "GAB", "GMB", "GEO", "DEU", "GHA", "GIB", "GRC", "GRL", "GRD", "GLP", "GUM", "GTM", "GGY", "GIN", "GNB", "GUY", "HTI", "HMD", "VAT", "HND", "HKG", "HUN", "ISL", "IND", "IDN", "IRN", "IRQ", "IRL", "IMN", "ISR", "ITA", "JAM", "JPN", "JEY", "JOR", "KAZ", "KEN", "KIR", "PRK", "KOR", "KWT", "KGZ", "LAO", "LVA", "LBN", "LSO", "LBR", "LBY", "LIE", "LTU", "LUX", "MAC", "MKD", "MDG", "MWI", "MYS", "MDV", "MLI", "MLT", "MHL", "MTQ", "MRT", "MUS", "MYT", "MEX", "FSM", "MDA", "MCO", "MNG", "MNE", "MSR", "MAR", "MOZ", "MMR", "NAM", "NRU", "NPL", "NLD", "NCL", "NZL", "NIC", "NER", "NGA", "NIU", "NFK", "MNP", "NOR", "OMN", "PAK", "PLW", "PSE", "PAN", "PNG", "PRY", "PER", "PHL", "PCN", "POL", "PRT", "PRI", "QAT", "REU", "ROU", "RUS", "RWA", "BLM", "SHN", "KNA", "LCA", "MAF", "SPM", "VCT", "WSM", "SMR", "STP", "SAU", "SEN", "SRB", "SYC", "SLE", "SGP", "SXM", "SVK", "SVN", "SLB", "SOM", "ZAF", "SGS", "SSD", "ESP", "LKA", "SDN", "SUR", "SJM", "SWZ", "SWE", "CHE", "SYR", "TWN", "TJK", "TZA", "THA", "TLS", "TGO", "TKL", "TON", "TTO", "TUN", "TUR", "TKM", "TCA", "TUV", "UGA", "UKR", "ARE", "GBR", "USA", "UMI", "URY", "UZB", "VUT", "VEN", "VNM", "VGB", "VIR", "WLF", "ESH", "YEM", "ZMB", "ZWE"]
        
        if countryCodeList.contains(self) {
            let base : UInt32 = 127397
            for scalar in self.unicodeScalars {
                flagString.unicodeScalars.append(UnicodeScalar(base + scalar.value)!)
            }
            
            return String(flagString.dropLast())
            
        } else {
            return ""
        }
    }
}

//
//  PreviewError.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/6/20.
//  Copyright © 2020 MonitorMOJO, Inc. All rights reserved.
//

import Foundation

public enum PreviewError: Error, CustomStringConvertible {
    case noURLHasBeenFound(String?)
    case invalidURL(String?)
    case cannotBeOpened(String?)
    case parseError(String?)

    public var description: String {
        switch(self) {
        case .noURLHasBeenFound(let error):
            return NSLocalizedString("No URL has been found. \(reason(error))", comment: String())
        case .invalidURL(let error):
            return NSLocalizedString("This data is not valid URL. \(reason(error)).", comment: String())
        case .cannotBeOpened(let error):
            return NSLocalizedString("This URL cannot be opened. \(reason(error)).", comment: String())
        case .parseError(let error):
            return NSLocalizedString("An error occurred when parsing the HTML. \(reason(error)).", comment: String())
        }
    }

    private func reason(_ error: String?) -> String {
        return "Reason: \(error ?? String())"
    }

}

//
//  OptionalExtension.swift
//  Liftoff
//
//  Created by Matthew Turk on 7/10/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation

extension Optional {
    func `do`(block: (Wrapped) -> Void) {
        guard case .some(let unwrapped) = self else { return }
        block(unwrapped)
    }
}

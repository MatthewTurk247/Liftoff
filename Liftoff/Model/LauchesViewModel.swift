//
//  LauchesViewModel.swift
//  Liftoff
//
//  Created by Matthew Turk on 7/10/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import RxCocoa
import RxSwift

struct LaunchesViewModel {
    let disposeBag = DisposeBag()
    
    func doStuff() {
        let foo = \LaunchesViewModel.disposeBag
        let viewModel = LaunchesViewModel()
        let bar = viewModel[keyPath: foo]
    }
}


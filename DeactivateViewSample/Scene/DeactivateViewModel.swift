//
//  DeactivateViewModel.swift
//  DeactivateViewSample
//
//  Created by Davidyoon on 5/31/24.
//

import Foundation
import Combine

struct DeactivateViewModel {
    
    struct Inputs {
        let viewDidLoad: AnyPublisher<Void, Never>
    }
    
    struct Outputs {
        let events: AnyPublisher<Void, Never>
    }
    
}

extension DeactivateViewModel {
    
    func bind(_ inputs: Inputs) -> Outputs {
        
        let events = Publishers.MergeMany(
            inputs.viewDidLoad
                .map {
                    print("ViewDidLoad")
                }
        )
            .eraseToAnyPublisher()
        
        return .init(events: .init(events))
    }
    
}

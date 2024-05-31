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
        let segmentSelected: AnyPublisher<Int, Never>
    }
    
    struct Outputs {
        let items: AnyPublisher<[ViewItem], Never>
        let events: AnyPublisher<Void, Never>
    }
    
}

extension DeactivateViewModel {
    
    func bind(_ inputs: Inputs) -> Outputs {
        
        let itemsSubject = CurrentValueSubject<[ViewItem], Never>.init(
            [
                .image(SampleItem(type: .enable).imageViewItem),
                .title(SampleItem(type: .enable).titleViewItem),
                .description(SampleItem(type: .enable).descriptionsViewItem)
            ]
        )
        
        let events = Publishers.MergeMany(
            inputs.viewDidLoad
                .map {
                    print("ViewDidLoad")
                }
                .eraseToAnyPublisher(),
            inputs.segmentSelected
                .map {
                    print("Selected: \($0)")
                }
                .map { _ in }
                .eraseToAnyPublisher()
        )
            .eraseToAnyPublisher()
        
        return .init(items: itemsSubject.eraseToAnyPublisher(), events: .init(events))
    }
    
}

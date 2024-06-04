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
        let buttonEnabled: AnyPublisher<Bool, Never>
        let events: AnyPublisher<Void, Never>
    }
    
}

extension DeactivateViewModel {
    
    func bind(_ inputs: Inputs) -> Outputs {
        
        let itemsSubject = CurrentValueSubject<[ViewItem], Never>.init(ViewItem.enableViewItem)
        let buttonEnabledSubject: CurrentValueSubject<Bool, Never> = .init(false)
        
        let events = Publishers.MergeMany(
            inputs.viewDidLoad
                .map {
                    print("ViewDidLoad")
                }
                .eraseToAnyPublisher(),
            inputs.segmentSelected
                .map {
                    print("Selected: \($0)")
                    if $0 == 0 {
                        itemsSubject.send(ViewItem.enableViewItem)
                        buttonEnabledSubject.send(true)
                    } else {
                        itemsSubject.send(ViewItem.disableViewItem)
                        buttonEnabledSubject.send(false)
                    }
                    
                }
                .map { _ in }
                .eraseToAnyPublisher()
        )
            .eraseToAnyPublisher()
        
        return .init(
            items: itemsSubject.eraseToAnyPublisher(),
            buttonEnabled: buttonEnabledSubject.eraseToAnyPublisher(),
            events: .init(events)
        )
    }
    
}


extension ViewItem {
    
    static let enableViewItem: [Self] = [
        .image(SampleItem(type: .enable).imageViewItem),
        .title(SampleItem(type: .enable).titleViewItem)
    ] + SampleItem(type: .enable).descriptionsViewItem.map { .description($0) }
    
    
    static let disableViewItem: [Self] = [
        .image(SampleItem(type: .disable).imageViewItem),
        .title(SampleItem(type: .disable).titleViewItem)
    ] + SampleItem(type: .disable).descriptionsViewItem.map { .description($0) }
    
}

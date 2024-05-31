//
//  DeactivateViewController.swift
//  DeactivateViewSample
//
//  Created by Davidyoon on 5/31/24.
//

import UIKit
import SnapKit
import Combine

enum ViewPage: String, CaseIterable {
    case enable = "Enable"
    case disable = "Disable"
}

final class DeactivateViewController: UIViewController {
    
    private let viewModel: DeactivateViewModel
    private let viewDidLoadPublisher: PassthroughSubject<Void, Never> = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    private let pages: [String] = ViewPage.allCases.map { $0.rawValue }
    
    private lazy var stateSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: self.pages)
        segmentControl.selectedSegmentIndex = 0
        
        return segmentControl
    }()
    
    init(viewModel: DeactivateViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.bindViewModel()
        self.viewDidLoadPublisher.send()
    }
    
}

private extension DeactivateViewController {
    
    func setupViews() {
        self.view.backgroundColor = .systemBackground
        
        [
            self.stateSegmentControl
        ]
            .forEach {
                self.view.addSubview($0)
            }
        
        self.stateSegmentControl.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(4)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func bindViewModel() {
        let viewDidLoadPublisher = self.viewDidLoadPublisher.eraseToAnyPublisher()
        
        let outputs = self.viewModel.bind(.init(viewDidLoad: viewDidLoadPublisher))
        
        [
            outputs.events
                .sink(receiveValue: { _ in })
        ].forEach {
            self.cancellables.insert($0)
        }
    }
    
}


#Preview {
    UINavigationController(rootViewController: DeactivateViewController(viewModel: DeactivateViewModel()))
}

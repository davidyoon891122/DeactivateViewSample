//
//  DeactivateViewController.swift
//  DeactivateViewSample
//
//  Created by Davidyoon on 5/31/24.
//

import UIKit
import Combine
import SnapKit
import CombineCocoa

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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
        
        tableView.register(DeactiveImageCell.self, forCellReuseIdentifier: DeactiveImageCell.identifier)
        tableView.register(DeactiveTitleCell.self, forCellReuseIdentifier: DeactiveTitleCell.identifier)
        tableView.register(DeactiveDescriptionCell.self, forCellReuseIdentifier: DeactiveDescriptionCell.identifier)
        
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private lazy var deactivateButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("탈퇴하기", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .disabled)
        
        button.setBackgroundColor(color: .lightGray, forState: .disabled)
        button.setBackgroundColor(color: .black, forState: .normal)
        
        return button
    }()
    
    private lazy var dataSource: UITableViewDiffableDataSource<Int, ViewItem> = {
        .init(tableView: self.tableView) { tableView, indexPath, items in
            switch items {
            case .image(let item):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DeactiveImageCell.identifier) as? DeactiveImageCell else { return UITableViewCell() }
                
                cell.setupCell(viewItem: item)
                
                return cell
            case .title(let item):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DeactiveTitleCell.identifier) as? DeactiveTitleCell else { return UITableViewCell() }
                
                cell.setupCell(viewItem: item)
                
                return cell
            case .description(let item):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: DeactiveDescriptionCell.identifier) as? DeactiveDescriptionCell else { return UITableViewCell() }
                
                cell.setupCell(viewItem: item)
                
                return cell
            }
        }
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
            self.stateSegmentControl,
            self.tableView,
            self.deactivateButton
        ]
            .forEach {
                self.view.addSubview($0)
            }
        
        self.stateSegmentControl.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(4)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.stateSegmentControl.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(self.deactivateButton.snp.top).offset(-5)
        }
        
        self.deactivateButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-40)
            $0.height.equalTo(56)
        }
    }
    
    func bindViewModel() {
        let viewDidLoadPublisher = self.viewDidLoadPublisher.eraseToAnyPublisher()
        let segmentPublisher = self.stateSegmentControl.selectedSegmentIndexPublisher.eraseToAnyPublisher()
        
        let outputs = self.viewModel.bind(.init(
            viewDidLoad: viewDidLoadPublisher,
            segmentSelected: segmentPublisher
        ))
        
        [
            outputs.events
                .sink(receiveValue: { _ in }),
            outputs.items
                .sink(receiveValue: { [weak self] item in
                    self?.applySnapshot(data: item)
                }),
            outputs.buttonEnabled
                .assign(to: \.isEnabled, on: self.deactivateButton)
        ].forEach {
            self.cancellables.insert($0)
        }
    }
    
    func applySnapshot(data: [ViewItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, ViewItem>()
        snapshot.appendSections([0])
        snapshot.appendItems(data)
        self.dataSource.apply(snapshot, animatingDifferences: false)
    }
    
}


#Preview {
    UINavigationController(rootViewController: DeactivateViewController(viewModel: DeactivateViewModel()))
}

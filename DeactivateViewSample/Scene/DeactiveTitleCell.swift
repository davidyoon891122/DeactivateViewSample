//
//  DeactiveTitleCell.swift
//  DeactivateViewSample
//
//  Created by Davidyoon on 5/31/24.
//

import UIKit
import SnapKit

final class DeactiveTitleCell: UITableViewCell {
    
    static let identifier = String(describing: DeactiveImageCell.self)
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "1\n2\n3"
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        [
            self.titleLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        self.titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(viewItem: TitleViewItem) {
        self.titleLabel.text = viewItem.title
    }
    
}

private extension DeactiveTitleCell {
    
    func setupViews() {
        self.contentView.addSubview(self.containerView)
        
        self.containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(64)
        }
    }
    
}

#Preview {
    DeactiveTitleCell()
}

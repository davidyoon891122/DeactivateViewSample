//
//  DeactiveTitleCell.swift
//  DeactivateViewSample
//
//  Created by Davidyoon on 5/31/24.
//

import UIKit
import SnapKit

final class DeactiveTitleCell: UITableViewCell {
    
    static let identifier = String(describing: DeactiveTitleCell.self)
    
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
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }
    
}

private extension DeactiveTitleCell {
    
    func setupViews() {
        self.selectionStyle = .none
        self.contentView.addSubview(self.containerView)
        
        self.containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func reset() {
        self.titleLabel.text = nil
    }
    
}

#Preview {
    DeactiveTitleCell()
}

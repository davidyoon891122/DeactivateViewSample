//
//  DeactiveDescriptionCell.swift
//  DeactivateViewSample
//
//  Created by Davidyoon on 5/31/24.
//

import UIKit
import SnapKit

final class DeactiveDescriptionCell: UITableViewCell {
    
    static let identifier = String(describing: DeactiveDescriptionCell.self)
    
    private lazy var exclamationIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "exclamationmark")
        
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "description"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        [
            self.exclamationIconImageView,
            self.descriptionLabel
        ]
            .forEach {
                view.addSubview($0)
            }
        
        self.exclamationIconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(16)
            $0.leading.equalToSuperview().offset(20)
            
        }
        
        self.descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalTo(self.exclamationIconImageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().offset(-20)
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
    
    func setupCell(viewItem: DescriptionViewItem) {
        self.descriptionLabel.text = viewItem.description
    }
    
}

private extension DeactiveDescriptionCell {
    
    func setupViews() {
        self.selectionStyle = .none
        self.contentView.addSubview(self.containerView)
        
        self.containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}


#Preview {
    DeactiveDescriptionCell()
}

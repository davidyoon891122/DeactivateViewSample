//
//  DeactiveImageCell.swift
//  DeactivateViewSample
//
//  Created by Davidyoon on 5/31/24.
//

import UIKit
import SnapKit

final class DeactiveImageCell: UITableViewCell {
    
    static let identifier = String(describing: DeactiveImageCell.self)
    
    private lazy var deactiveImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        
        return imageView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        
        [
            self.deactiveImageView
        ]
            .forEach {
                view.addSubview($0)
            }
        
        self.deactiveImageView.snp.makeConstraints {
            $0.width.height.equalTo(125)
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
    
    func setupCell(viewItem: ImageViewItem) {
        
    }
    
}

private extension DeactiveImageCell {
    
    func setupViews() {
        self.contentView.addSubview(self.containerView)
        
        self.containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(172)
        }
    }
    
}

#Preview {
    DeactiveImageCell()
}

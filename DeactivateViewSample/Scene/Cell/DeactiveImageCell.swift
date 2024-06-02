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
        imageView.contentMode = .scaleAspectFit
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
            $0.height.width.equalTo(124).priority(.high)
            $0.top.equalToSuperview().offset(32)
            $0.bottom.equalToSuperview().offset(-32)
            $0.leading.trailing.equalToSuperview()
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
        self.deactiveImageView.image = viewItem.image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }
    
}

private extension DeactiveImageCell {
    
    func setupViews() {
        self.selectionStyle = .none
        self.contentView.addSubview(self.containerView)
        
        self.containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func reset() {
        self.deactiveImageView.image = nil
    }
    
}

#Preview {
    DeactiveImageCell()
}

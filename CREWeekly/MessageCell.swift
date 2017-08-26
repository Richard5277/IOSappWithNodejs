//
//  MessaegCell.swift
//  CREWeekly
//
//  Created by Feihong Zhao on 2017-08-21.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import SnapKit

class MessageCell: UICollectionViewCell {
    var titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(60)
        }
    }
    
}

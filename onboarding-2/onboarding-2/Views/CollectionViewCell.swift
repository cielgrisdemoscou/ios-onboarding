//
//  CollectionViewCell.swift
//  onboarding-2
//
//  Created by Ted on 2021/03/09.
//

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private var tintView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private var labelContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = UIFont(name: "Bangla Sangam MN", size: 25)
        label.textColor = .black
        return label
    }()
    
    var detailLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = UIFont(name: "Bangla Sangam MN", size: 15)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configreUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    func configreUI(){
        
        addSubview(tintView)

        tintView.snp.makeConstraints { (make) -> Void in
            make.top.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        addSubview(labelContainerView)
        
        labelContainerView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(tintView).inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.leading.trailing.equalTo(labelContainerView).inset(UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        }
        
        addSubview(detailLabel)
        
        detailLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(labelContainerView).inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
    }
}

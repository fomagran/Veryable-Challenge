//
//  AccountSectionHeaderView.swift
//  Veryable Sample
//
//  Created by Fomagran on 2022/12/15.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import UIKit
import SnapKit

class AccountSectionHeaderView: UIView {
    
    //MARK: - UIs
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = type
        label.font = UIFont.vryAvenirNextDemiBold(16)
        label.textColor = ViewColor.greyDark.color
        return label
    }()
    
    private let topGreyLine: UIView = {
        let line = UIView()
        line.backgroundColor = ViewColor.greyLight.color
        return line
    }()
    
    //MARK: - Initializers
    
    init(frame: CGRect, type: String) {
        super.init(frame: frame)
        self.type = type
        self.backgroundColor = ViewColor.greyDisabled.color.withAlphaComponent(0.5)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set up
    
    private func setupViews() {
        addSubview(title)
        addSubview(topGreyLine)
    }
    
    private func setupConstraints() {
        topGreyLine.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.top.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
        }
        
        title.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(0)
            $0.top.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(0)
        }
    }
}

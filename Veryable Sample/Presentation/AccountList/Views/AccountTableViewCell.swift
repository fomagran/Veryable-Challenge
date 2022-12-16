//
//  AccountTableViewCell.swift
//  Veryable Sample
//
//  Created by Fomagran on 2022/12/15.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import UIKit
import SnapKit
import ReactorKit

class AccountTableViewCell: UITableViewCell, View {
    
    //MARK: - Properties
    
    var disposeBag = DisposeBag()
    
    //MARK: - UIs
    
    private let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageName.bank.rawValue)
        imageView.tintColor = ViewColor.primaryBlueDark.color
        return imageView
    }()
    
    private let rightArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageName.arrow.rawValue)
        imageView.tintColor = ViewColor.grey.color
        return imageView
    }()
    
    private let accountName: UILabel = {
        let label = UILabel()
        label.font = UIFont.vryAvenirNextDemiBold(14)
        label.text = "account name"
        label.textColor = ViewColor.accountName.color
        return label
    }()
    
    private let desc: UILabel = {
        let label = UILabel()
        label.font = UIFont.vryAvenirNextRegular(12)
        label.text = "desc"
        label.textColor = ViewColor.accountName.color
        return label
    }()
    
    private let accountType: UILabel = {
        let label = UILabel()
        label.font = UIFont.vryAvenirNextRegular(12)
        label.text = "account type"
        label.textColor = ViewColor.desc.color
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let topGreyLine: UIView = {
        let line = UIView()
        line.backgroundColor = ViewColor.greyLight.color
        return line
    }()
    
    //MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
        self.setContraints()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Set up
    
    func bind(reactor: AccountReactor) {
        let account = reactor.currentState.account
        let imageName = account.accountType == "bank" ? ImageName.bank.rawValue : ImageName.card.rawValue
        logo.image = UIImage(named: imageName)
        accountType.text = account.accountType == "Bank Accounts" ? "Bank Account ACH - Same Day" : "Card: Instant"
        accountName.text = account.accountName
        desc.text = account.desc
    }
    
    private func setupView() {
        self.addSubview(logo)
        self.addSubview(accountName)
        self.addSubview(accountType)
        self.addSubview(desc)
        
        stackView.addArrangedSubview(accountName)
        stackView.addArrangedSubview(desc)
        stackView.addArrangedSubview(accountType)
        
        self.addSubview(stackView)
        self.addSubview(rightArrow)
        self.addSubview(topGreyLine)
    }
    
    private func setContraints() {
        topGreyLine.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.top.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
        }
        
        logo.snp.makeConstraints {
            $0.width.equalTo(20)
            $0.height.equalTo(20)
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(15)
        }
        
        rightArrow.snp.makeConstraints {
            $0.width.equalTo(25)
            $0.height.equalTo(25)
            $0.centerY.equalTo(self)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalTo(logo.snp.trailing).offset(20)
            $0.trailing.equalTo(rightArrow.snp.leading).offset(0)
            $0.bottom.equalToSuperview().offset(-15)
        }
    }
}

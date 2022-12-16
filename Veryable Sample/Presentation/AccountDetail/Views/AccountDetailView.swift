//
//  AccountDetailView.swift
//  Veryable Sample
//
//  Created by Fomagran on 2022/12/15.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class AccountDetailView: UIView {
    
    //MARK: - Properties
    
    let disposeBag = DisposeBag()
    
    //MARK: - UIs
    
    let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageName.bank.rawValue)
        imageView.tintColor = ViewColor.primaryBlueDark.color
        return imageView
    }()
    
    let accountName: UILabel = {
        let label = UILabel()
        label.text = "account Name"
        label.font = UIFont.vryAvenirNextDemiBold(16)
        label.textColor = ViewColor.accountName.color
        return label
    }()
    
    let desc : UILabel = {
        let label = UILabel()
        label.text = "desc"
        label.font = UIFont.vryAvenirNextRegular(14)
        label.textColor = ViewColor.desc.color
        return label
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ViewColor.primaryBlueDark.color
        button.setTitle("DONE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 2
        button.titleLabel?.font = UIFont.vryAvenirNextBold(16)
        return button
    }()
    
    
    //MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = ViewColor.greyDisabled.color.withAlphaComponent(0.5)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Set up
    
    func bind(reactor: AccountDetailReactor) {
        let account = reactor.currentState.account
        accountName.text = account.accountName
        desc.text = account.desc
        let imageName = account.accountType == "bank" ? ImageName.bank.rawValue : ImageName.card.rawValue
        logo.image = UIImage(named: imageName)
        
        //Reactor Action
        
        doneButton.rx.tap
            .map{ AccountDetailReactor.Action.tapDoneButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func setupViews() {
        addSubview(logo)
        addSubview(accountName)
        addSubview(desc)
        addSubview(doneButton)
    }
    
    private func setupConstraints() {
        logo.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(100)
            $0.centerX.equalTo(self)
            $0.top.equalToSuperview().offset(20)
        }
        
        accountName.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(logo.snp.bottom).offset(20)
        }
        
        desc.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(accountName.snp.bottom).offset(3)
        }
        
        doneButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.bottom.equalToSuperview().offset(-30)
        }
    }
}

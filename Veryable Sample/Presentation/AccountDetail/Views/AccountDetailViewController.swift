//
//  AccountDetailViewController.swift
//  Veryable Sample
//
//  Created by Fomagran on 2022/12/15.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import UIKit
import SnapKit
import ReactorKit

class AccountDetailViewController: UIViewController, View {
    
    //MARK: - Properties
    
    lazy var detailView = AccountDetailView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 0)))
    var disposeBag = DisposeBag()
    var reactor: AccountDetailReactor!
    
    //MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - Set up
    
    func bind(reactor: AccountDetailReactor) {
        
        detailView.bind(reactor: reactor)
        
        //Reactor Action
        
        navigationItem.leftBarButtonItem?.rx.tap
            .map { AccountDetailReactor.Action.tapBackButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        //Reactor State
        
        reactor.state.map { $0.goBack }
            .distinctUntilChanged()
            .filter{ $0 }
            .asDriver(onErrorJustReturn: false)
            .drive { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func configure() {
        setupViews()
        setupConstraints()
        setupCustomNavigationBar()
        bind(reactor: reactor)
    }

    private func setupViews() {
        view.addSubview(detailView)
    }
    
    private func setupConstraints() {
        detailView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            $0.bottom.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
        }
    }
    
    private func setupCustomNavigationBar() {
        title = "Details".uppercased()
        let attributes = [NSAttributedString.Key.font : UIFont.vryAvenirNextMedium(17), NSAttributedString.Key.foregroundColor : ViewColor.grey.color]
        navigationController?.navigationBar.titleTextAttributes = attributes
        additionalSafeAreaInsets.top = 10
        navigationController?.navigationBar.backgroundColor = .white
        view.backgroundColor = .white
        
        let back = UIImage(named: ImageName.back.rawValue)?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: back, style:.plain, target: self, action: nil)
    }
}


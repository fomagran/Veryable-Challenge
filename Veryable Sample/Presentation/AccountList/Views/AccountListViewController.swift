//
//  AccountListViewController.swift
//  Veryable Sample
//
//  Created by Isaac Sheets on 5/27/21.
//  Copyright © 2021 Veryable Inc. All rights reserved.
//

import UIKit
import SnapKit
import ReactorKit
import RxDataSources
import RxCocoa

class AccountListViewController: UIViewController, View {
    
    //MARK: - Properties
    
    private let table = UITableView()
    var reactor = AccountListReactor()
    var detailReactor: AccountDetailReactor?
    var disposeBag = DisposeBag()
    
    //MARK: - UIs
    
    let alert: UIAlertController = {
        let alertController = UIAlertController(title: "", message:"", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        return alertController
    }()
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        detailReactor?.state.map { $0.alertType }
            .compactMap{ $0 }
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] alertType in
                self?.showAlert(alertType)
            })
            .disposed(by: disposeBag)
    }
    
    //MARK: - Set up
    
    func bind(reactor: AccountListReactor) {
        
        //Reactor Action
        
        reactor.action.onNext(.load)
        
        //Reactor State
        
        let dataSource = RxTableViewSectionedReloadDataSource<AccountList>(
            configureCell: { [weak self] dataSource, tableView, indexPath, account in
                guard let cell = self?.table.dequeueReusableCell(withIdentifier: CellIdentifier.AccountTableViewCell.rawValue) as? AccountTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.selectionStyle = .none
                cell.bind(reactor: AccountReactor(account: account))
                return cell
            })
        
        reactor.state.map { $0.accountLists }
            .bind(to: table.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.alertInfo }
            .distinctUntilChanged()
            .compactMap { $0 }
            .asDriver(onErrorJustReturn: "RxError")
            .drive{ [weak self] alertInfo in
                self?.showAlert(.error,alertInfo)
            }.disposed(by: disposeBag)

        
        reactor.state.map { $0.selectedAccount }
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: nil)
            .drive{ [weak self] selectedAccount in
                if let selectedAccount = selectedAccount {
                    self?.detailReactor = AccountDetailReactor(account: selectedAccount)
                }

                let detailVC = AccountDetailViewController()
                if let detailReactor = self?.detailReactor {
                    detailVC.reactor = detailReactor
                    self?.navigationController?.pushViewController(detailVC, animated: true)
                }
            }.disposed(by: disposeBag)
    }
    
    private func configure() {
        setupCustomNavigationBar()
        setupViews()
        setConstraints()
        bind(reactor: reactor)
    }
    
    private func setupCustomNavigationBar() {
        title = "Accounts".uppercased()
        let attributes = [NSAttributedString.Key.font : UIFont.vryAvenirNextMedium(17), NSAttributedString.Key.foregroundColor : ViewColor.grey.color]
        navigationController?.navigationBar.titleTextAttributes = attributes
        additionalSafeAreaInsets.top = 10
    }
    
    private func setupViews() {
        self.view.addSubview(table)
        setupTable()
    }
    
    private func setupTable() {
        table.register(AccountTableViewCell.self, forCellReuseIdentifier: CellIdentifier.AccountTableViewCell.rawValue)
        table.separatorStyle = .none
        if #available(iOS 15.0, *) {
            self.table.sectionHeaderTopPadding = 0
        }
        
        table
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        table.rx.rowHeight.onNext(100)
        table.rx.sectionHeaderHeight.onNext(45)
        
        table.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else {
                    return
                }
                let account = self.reactor.currentState.accountLists[indexPath.section].items[indexPath.row]
                self.reactor.action.onNext(.tapAccount(account: account))
            
            }).disposed(by: disposeBag)
    }
    
    private func setConstraints() {
        table.snp.makeConstraints {
            $0.top.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(0)
        }
    }
    
    //MARK: - Functions
    
    private func showAlert(_ alertType: AlertType,_ alertMessage: String = "") {
        alert.title = alertType.rawValue.uppercased()
        if alertType == .back || alertType == .done {
            alert.message = "From: \(detailReactor?.currentState.account.desc ?? "")"
        } else {
            alert.message = alertMessage
        }
        self.present(alert, animated: true)
    }
}

//MARK: UITableViewDelegate

extension AccountListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerFrame = CGRect(x: 0, y: 0, width: self.view.frame.width,  height: 45)
        let types = reactor.currentState.accountLists
        let sectionHeaderView = AccountSectionHeaderView(frame: headerFrame, type: types[section].accountType)
        return sectionHeaderView
    }
}

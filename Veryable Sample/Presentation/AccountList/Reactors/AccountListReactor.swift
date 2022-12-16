//
//  AccountListReactor.swift
//  Veryable Sample
//
//  Created by Fomagran on 2022/12/15.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import Foundation
import ReactorKit

class AccountListReactor: Reactor {
    var initialState: State
    var accountUseCase: AccountUseCase
    let disposeBag = DisposeBag()
    
    init(accountUseCase: AccountUseCase = DefaultAccountUseCase()) {
        self.initialState = State(accountLists: [])
        self.accountUseCase = accountUseCase
    }
    
    enum Action {
        case load
        case tapAccount(account: Account)
    }
    
    enum Mutation {
        case setAccountLists([AccountList])
        case setAlert(message: String)
        case setSelectedAccount(account: Account)
    }
    
    struct State {
        var accountLists: [AccountList]
        var selectedAccount: Account?
        var alertInfo: String?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            return fetchAccountLists()
        case let .tapAccount(account: account):
            return Observable.just(Mutation.setSelectedAccount(account: account))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setAccountLists(accountLists):
            newState.accountLists = accountLists
        case let .setAlert(message: message):
            newState.alertInfo = message
        case let .setSelectedAccount(account: account):
            newState.selectedAccount = account
        }
        return newState
    }
    
    @discardableResult
    func fetchAccountLists() -> Observable<Mutation> {
        return Observable.create{ observer in
            self.accountUseCase.execute()
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] accounts in
                    let accountLists = self?.changeAccountsToAccountLists(accounts)
                    observer.onNext(.setAccountLists(accountLists ?? []))
                }, onError: { error in
                    if error is NetworkError {
                        observer.onNext(.setAlert(message: (error as! NetworkError).reason))
                    } else {
                        observer.onNext(.setAlert(message: error.localizedDescription))
                    }
                })
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    private func changeAccountsToAccountLists(_ accounts: [Account]) -> [AccountList] {
        let banks = accounts.filter { $0.accountType == AccountType.bank.rawValue }
        let cards = accounts.filter { $0.accountType == AccountType.card.rawValue }
        let bankAccountList = AccountList(accountType: AccountType.bank.header, items: banks)
        let cardAccountList = AccountList(accountType: AccountType.card.header, items: cards)
        return [bankAccountList,cardAccountList]
    }
}

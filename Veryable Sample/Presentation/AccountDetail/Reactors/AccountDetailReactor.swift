//
//  AccountDetailReactor.swift
//  Veryable Sample
//
//  Created by Fomagran on 2022/12/15.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import Foundation
import ReactorKit

class AccountDetailReactor: Reactor {
    var initialState: State
    
    init(account: Account) {
        self.initialState = State(account: account,goBack: false)
    }
    
    enum Action {
        case tapBackButton
        case tapDoneButton
    }
    
    enum Mutation {
        case setGoBack(Bool)
        case setAlertType(AlertType)
    }
    
    struct State {
        var account: Account
        var goBack: Bool
        var alertType: AlertType?
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapBackButton:
            return Observable.concat([Observable.just(Mutation.setGoBack(true)),
                                      Observable.just(Mutation.setAlertType(.back))])
        case .tapDoneButton:
            return Observable.concat([Observable.just(Mutation.setGoBack(true)),
                                      Observable.just(Mutation.setAlertType(.done))])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setGoBack(goBack):
            newState.goBack = goBack
        case let .setAlertType(alertType):
            newState.alertType = alertType
        }

        return newState
    }
}

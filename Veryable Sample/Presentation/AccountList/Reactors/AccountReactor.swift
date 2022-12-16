//
//  AccountReactor.swift
//  Veryable Sample
//
//  Created by Fomagran on 2022/12/15.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import ReactorKit

class AccountReactor: Reactor {
    var initialState: State
    
    init(account: Account) {
        self.initialState = State(account: account)
    }

    enum Action {}
    
    enum Mutation {}
    
    struct State {
        var account: Account
    }
}

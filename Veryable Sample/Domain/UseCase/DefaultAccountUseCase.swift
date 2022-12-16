//
//  DefaultAccountUseCase.swift
//  Veryable Sample
//
//  Created by Fomagran on 2022/12/15.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import Foundation
import RxSwift

class DefaultAccountUseCase: AccountUseCase {
    var repository: AccountRepository
    
    init(repository: AccountRepository = DefaultAccountRepository()) {
        self.repository = repository
    }
    
    @discardableResult
    func execute() -> RxSwift.Observable<[Account]> {
        let accounts = repository.load()
        return accounts
    }
}

//
//  DefaultAccountRepository.swift
//  Veryable Sample
//
//  Created by Fomagran on 2022/12/15.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import Foundation
import RxSwift

class DefaultAccountRepository: AccountRepository {
    var service: AccountService
    
    init(service: AccountService = DefaultAccountService()) {
        self.service = service
    }
    
    @discardableResult
    func load() -> Observable<[Account]> {
        let accountRequest = DefaultAccountRequest()
        let accounts = service.request(accountRequest)
        return accounts
    }
}

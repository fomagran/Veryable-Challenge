//
//  AccountService.swift
//  Veryable Sample
//
//  Created by Fomagran on 2022/12/15.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import Foundation
import RxSwift

protocol AccountRequest {
    var url: String { get }
}

protocol AccountService {
    func request(_ request: AccountRequest) -> Observable<[Account]>
}

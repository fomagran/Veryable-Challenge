//
//  MockAccountRepository.swift
//  Veryable SampleTests
//
//  Created by Fomagran on 2022/12/15.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import Foundation
@testable import Veryable_Sample
import RxSwift

class MockAccountRepository: AccountRepository {
    var isError = false

    func load() -> Observable<[Account]> {
        return Observable<[Account]>.create { [weak self] observer in
            if self!.isError {
                observer.onError(NetworkError.error(reason: "Test Error"))
            } else {
                observer.onNext(DummyData.dummyAccounts)
            }
            return Disposables.create()
        }
    }
}

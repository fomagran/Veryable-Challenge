//
//  AccountUseCaseTests.swift
//  Veryable SampleTests
//
//  Created by Fomagran on 2022/12/15.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import XCTest
@testable import Veryable_Sample
import RxSwift

class AccountUseCaseTests: XCTestCase {
    var disposeBag = DisposeBag()
    var sut: AccountUseCase!
    
    func testAccountUseCase_whenSuccessExcecute_ShouldEmitAccounts() {
        let expect = expectation(description:"Use case emit dummy accounts")
        
        //Given
        let mockAccountRepository = MockAccountRepository()
        sut = DefaultAccountUseCase(repository: mockAccountRepository)
        
        //When
        sut.execute()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { accounts in
                //Then
                expect.fulfill()
                XCTAssertEqual(DummyData.dummyAccounts, accounts)
                XCTAssertNotNil(accounts)
            })
            .disposed(by: disposeBag)
        
        wait(for: [expect],timeout:0.1)
    }
    
    func testAccountUseCase_whenFailedExcecute_ShouldEmitNetworkError() {
        let expect = expectation(description:"Use case emit a error")
        
        //Given
        let mockAccountRepository = MockAccountRepository()
        mockAccountRepository.isError = true
        sut = DefaultAccountUseCase(repository: mockAccountRepository)
        
        //When
        sut.execute()
            .observe(on: MainScheduler.instance)
            .subscribe(onError: { error in
                //Then
                XCTAssertTrue(error is NetworkError)
                expect.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [expect],timeout:0.1)
    }
}

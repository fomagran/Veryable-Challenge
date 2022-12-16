//
//  AccountRepositoryTests.swift
//  Veryable SampleTests
//
//  Created by Fomagran on 2022/12/15.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import XCTest
@testable import Veryable_Sample
import RxSwift

final class AccountRepositoryTests: XCTestCase {

    var sut: AccountRepository!
    var disposeBag = DisposeBag()
    
    func testAccountRepository_whenSuccessLoad_ShouldEmitAccounts() {
        let expect = expectation(description:"Repository emit dummy accounts")
        
        //Given
        let mockAccountService = MockAccountService()
        sut = DefaultAccountRepository(service: mockAccountService)
        
        //When
        sut.load()
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
    
    func testAccountRepository_whenFailedLoad_ShouldEmitNetworkError() {
        let expect = expectation(description:"Repository case emit a error")
        
        //Given
        let mockAccountService = MockAccountService()
        mockAccountService.isError = true
        sut = DefaultAccountRepository(service: mockAccountService)
        
        //When
        sut.load()
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

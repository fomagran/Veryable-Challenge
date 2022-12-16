//
//  AccountServiceTests.swift
//  Veryable SampleTests
//
//  Created by Fomagran on 2022/12/15.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import XCTest
@testable import Veryable_Sample
import RxSwift

final class AccountServiceTests: XCTestCase {
    var sut: AccountService!
    var disposeBag = DisposeBag()
    
    func testAccountService_whenRequestInvalidURL_shouldEmitInvalidURLError() {
        let expect = expectation(description:"Account service emit a invalid url error")
        
        //Given
        sut = DefaultAccountService()
        
        //When
        sut.request(InvalidURLAccountRequest())
            .observe(on: MainScheduler.instance)
            .subscribe(onError: { error in
                XCTAssertTrue((error as! NetworkError).reason == NetworkError.invalidURL.reason)
                //Then
                expect.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [expect], timeout: 0.1)
    }
    
    func testAccountService_whenRequestProper_shouldEmitProperAccounts() {
        let expect = expectation(description:"Account service emit a invalid url error")
        
        //Given
        sut = DefaultAccountService()
        
        //When
        sut.request(DefaultAccountRequest())
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { accounts in
                //Then
                XCTAssertNotNil(accounts)
                expect.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [expect], timeout: 0.1)
    }
}

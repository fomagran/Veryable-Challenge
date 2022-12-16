//
//  AccountListTests.swift
//  Veryable SampleTests
//
//  Created by Fomagran on 2022/12/15.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import XCTest
@testable import Veryable_Sample
import RxSwift

final class AccountListTests: XCTestCase {
    
    var disposeBag = DisposeBag()
    
    func testAccountList_whenDidLoadProper_thenAppearAccountLists() {
        // Given
        let accountListReactor = AccountListReactor()
        let mockRepository = MockAccountRepository()
        accountListReactor.accountUseCase = DefaultAccountUseCase(repository: mockRepository)
        
        // When
        accountListReactor.action.onNext(.load)
                
        // Then
        XCTAssertEqual(accountListReactor.currentState.accountLists.count, DummyData.dummyAccountLists.count)
    }
    
    func testAccountList_whenDidLoadError_thenShouldShowErrorAlert() {
        // Given
        let accountListReactor = AccountListReactor()
        let mockRepository = MockAccountRepository()
        mockRepository.isError = true
        accountListReactor.accountUseCase = DefaultAccountUseCase(repository: mockRepository)
        
        // When
        accountListReactor.action.onNext(.load)
                
        // Then
        XCTAssertEqual(accountListReactor.currentState.alertInfo, "Test Error")
    }
    
    func testAccountList_whenDidTapAccountInList_thenSelectedAccountShouldBeNotNill() {
        // Given
        let accountListReactor = AccountListReactor()
        
        // When
        let dummyAccount = Account(id: 0, accountType: "", accountName: "", desc: "")
        accountListReactor.action.onNext(.tapAccount(account: dummyAccount))
                
        // Then
        XCTAssertNotNil(accountListReactor.currentState.selectedAccount)
    }
}

//
//  AccountDetailTests.swift
//  Veryable SampleTests
//
//  Created by Fomagran on 2022/12/15.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import XCTest
@testable import Veryable_Sample
import RxSwift

final class AccountDetailTests: XCTestCase {
    
    var sut = AccountDetailViewController()
    var disposeBag = DisposeBag()
    
    func testAccountDetail_whenBindedDetailView_thenShouldHaveProperAccountInfo() {
        // Given
        let detailView = sut.detailView
        let dummyAccount = DummyData.dummyAccounts[0]
        let accountDetailReactor = AccountDetailReactor(account: dummyAccount)
        
        // When
        detailView.bind(reactor: accountDetailReactor)
                
        // Then
        XCTAssertEqual(detailView.accountName.text, dummyAccount.accountName)
        XCTAssertEqual(detailView.desc.text, dummyAccount.desc)
        XCTAssertEqual(detailView.logo.image, UIImage(named: dummyAccount.accountType))
    }
    
    func testAccountList_whenDidTapDoneButton_thenGobackShouldBeTrue() {
        // Given
        let dummyAccount = DummyData.dummyAccounts[0]
        let accountDetailReactor = AccountDetailReactor(account: dummyAccount)
        
        // When
        accountDetailReactor.action.onNext(.tapDoneButton)
                
        // Then
       
    }
    
    func testAccountList_whenDidTapBackButton_thenGobackShouldBeTrue() {
        // Given
        let dummyAccount = DummyData.dummyAccounts[0]
        let accountDetailReactor = AccountDetailReactor(account: dummyAccount)
        
        // When
        accountDetailReactor.action.onNext(.tapBackButton)
                
        // Then
        XCTAssertTrue(accountDetailReactor.currentState.goBack)
    }
    
    func testAccountList_whenDidTapDoneButton_thenAlertTitleShouldBeDone() {
        // Given
        let dummyAccount = DummyData.dummyAccounts[0]
        let accountDetailReactor = AccountDetailReactor(account: dummyAccount)
        
        // When
        accountDetailReactor.action.onNext(.tapDoneButton)
                
        // Then
        XCTAssertEqual(accountDetailReactor.currentState.alertType, AlertType.done)
    }
    
    func testAccountList_whenDidTapDoneButton_thenAlertTitleShouldBeBack() {
        // Given
        let dummyAccount = DummyData.dummyAccounts[0]
        let accountDetailReactor = AccountDetailReactor(account: dummyAccount)
        
        // When
        accountDetailReactor.action.onNext(.tapBackButton)
                
        // Then
        XCTAssertEqual(accountDetailReactor.currentState.alertType, AlertType.back)
    }
}

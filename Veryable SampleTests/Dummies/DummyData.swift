//
//  DummyData.swift
//  Veryable SampleTests
//
//  Created by Fomagran on 2022/12/15.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import Foundation
@testable import Veryable_Sample

class DummyData {
   static let dummyAccounts: [Account] = {
        let bank1 = Account(id: 1, accountType: "bank", accountName: "bank1", desc: "desc1")
        let bank2 = Account(id: 2, accountType: "bank", accountName: "bank2", desc: "desc2")
        let card1 = Account(id: 3, accountType: "card", accountName: "card1", desc: "desc1")
       let card2 = Account(id: 3, accountType: "card", accountName: "card2", desc: "desc2")
       let card3 = Account(id: 3, accountType: "card", accountName: "card3", desc: "desc3")
        return [bank1, bank2,card1,card2,card3]
    }()
    
    static let dummyAccountLists: [AccountList] = {
        let banks = dummyAccounts.filter{ $0.accountType == "bank" }
        let cards = dummyAccounts.filter{ $0.accountType == "card" }
        
        let bankLists = AccountList(accountType: "bank", items: banks)
        let cardLists = AccountList(accountType: "card", items: cards)
        
        return [bankLists,cardLists]
    }()
}

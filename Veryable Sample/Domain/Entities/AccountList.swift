//
//  AccountList.swift
//  Veryable Sample
//
//  Created by Fomagran on 2022/12/15.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import Foundation
import RxDataSources

struct AccountList  {
    var accountType: String
    var items: [Account]
}

extension AccountList: SectionModelType {
    typealias Item = Account
    
    init(original: AccountList, items: [Item]) {
     self = original
     self.items = items
   }
}

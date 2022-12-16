//
//  AccountType.swift
//  Veryable Sample
//
//  Created by Fomagran on 2022/12/15.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import Foundation

enum AccountType: String {
    case bank
    case card
    
    var header: String {
        switch self {
        case .bank:
            return "Bank Accounts"
        case .card:
            return "Cards"
        }
    }
}

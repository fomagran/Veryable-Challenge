//
//  Account.swift
//  Veryable Sample
//
//  Created by Isaac Sheets on 5/27/21.
//  Copyright © 2021 Veryable Inc. All rights reserved.
//

import Foundation

struct Account: Decodable, Equatable {
    let id: Int
    let accountType: String
    let accountName: String
    let desc: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case accountType = "account_type"
        case accountName = "account_name"
        case desc
    }
    
    init(id: Int,accountType: String, accountName: String, desc: String) {
        self.id = id
        self.accountType = accountType
        self.accountName = accountName
        self.desc = desc
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        accountType = try values.decode(String.self, forKey: .accountType)
        accountName = try values.decode(String.self, forKey: .accountName)
        desc = try values.decode(String.self, forKey: .desc)
    }
}

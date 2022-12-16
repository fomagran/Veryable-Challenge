//
//  AccountRepository.swift
//  Veryable Sample
//
//  Created by Fomagran on 2022/12/15.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import Foundation
import RxSwift

protocol AccountRepository {
    func load() -> Observable<[Account]>
}

//
//  DefaultAccountService.swift
//  Veryable Sample
//
//  Created by Fomagran on 2022/12/15.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class DefaultAccountService: AccountService {
    func request(_ request: AccountRequest) -> Observable<[Account]> {
        return Observable<[Account]>.create { observer in
            let request = AF.request(request.url).responseDecodable(of: [Account].self) { response  in
                
                switch response.result {
                    
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                    
                case .failure(let error):
                    var networkError = NetworkError.error(reason: "")
                    switch error {
                    case .invalidURL(_):
                        networkError = .invalidURL
                    case .responseValidationFailed(_):
                        networkError = .responseValidationFailed
                    case .responseSerializationFailed(_):
                        networkError = .responseSerializationFailed
                    default:
                        networkError = .error(reason: error.localizedDescription)
                    }
                    
                    observer.onError(networkError)
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}


//
//  ObservableType.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 28/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import RxSwift

extension ObservableType where E == (response: HTTPURLResponse, data: Data) {
  
  func filterSuccessfulStatusCodes() -> Observable<NetworkResult> {
    return self.map { response, data -> NetworkResult in
      let statusCode = response.statusCode
      guard (200...299).contains(statusCode) else {
        return Result.failure(NetworkError.withCode(statusCode))
      }
      return Result.success(data)
    }
  }
  
}

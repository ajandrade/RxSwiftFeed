//
//  Result.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 28/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import Foundation

enum Result<T, E> {
  case success(T)
  case failure(E)
}

typealias NetworkResult = Result<Data, NetworkError>

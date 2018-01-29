//
//  Repository.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 29/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import Foundation

struct Repository: Decodable {
  let name: String
}

// EXAMPLE:
//"repo": {
//  "id": 33569135,
//  "name": "ReactiveX/RxSwift",
//  "url": "https://api.github.com/repos/ReactiveX/RxSwift"
//}

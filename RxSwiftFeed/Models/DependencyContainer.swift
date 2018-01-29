//
//  DependencyContainer.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 29/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import Foundation

protocol HasGithubProvider {
  var githubProvider: GithubAPIClientProtocol { get }
}

struct DependencyContainer: HasGithubProvider {
  let githubProvider: GithubAPIClientProtocol
}

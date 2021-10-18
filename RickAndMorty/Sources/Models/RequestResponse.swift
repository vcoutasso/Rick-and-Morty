//
//  RequestResult.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import Foundation

struct RequestResponse<T>: Decodable where T: Decodable {
    let info: RequestInfo
    let results: [T]
}

struct RequestInfo: Decodable {
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
}

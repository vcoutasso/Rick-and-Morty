//
//  RMCharacter.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 17/10/21.
//

import Foundation

struct RMCharacter: Decodable {
    let id: Int
    let name: String
    let status: String
    let species:  String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String

    struct Origin: Decodable {
        let name: String
        let url: String
    }

    struct Location: Decodable {
        let name: String
        let url: String
    }

    enum StatusValues: String {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }
}

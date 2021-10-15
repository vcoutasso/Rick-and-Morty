//
//  CharacterTableModels.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import Foundation

enum CharacterTable {

    struct Character: Decodable {
        let id: Int
        let name: String
        let status: String
        let species:  String
        let type: String
        let gender: String
        // TODO: Implement origin and location
        //let origin
        //let location
        let image: String
        let episode: [String]
        let url: String
        let created: String
    }

    enum FetchData {
        struct Request {
            let type: RequestType

            enum RequestType {
                case all
                case id(Int)
            }
        }

        struct Response {
            var response: RequestResult<Character>
        }
        
        struct ViewModel {
            var charactera: [Character]
        }
    }
}
